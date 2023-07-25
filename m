Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0F8762118
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 20:13:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOMWq-0002By-Ax; Tue, 25 Jul 2023 14:13:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qOMWn-0002Bl-SL
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 14:12:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qOMWm-0003EO-9y
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 14:12:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690308775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XhcxePtO8lQK0mT+MbSoIUDTZ1JhDNN6V7EwHUlXAzU=;
 b=dfpSVSndrKrw6dPbfNJSq8XpaNIsoakAnsERNstikmubbaA+myaLcl8wUjeiIealPTfTTo
 ckGFplMLleJC6F6+ijZyPPIZB43WAoJ6CvPgMgF54HL3oLad3pWYPX9w2X6htyegnjk/J6
 i2knBZEPYYCIDmlMlso6rSolFAifGNE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-TtiZTMDZPiu7wg_7so4ZrQ-1; Tue, 25 Jul 2023 14:12:53 -0400
X-MC-Unique: TtiZTMDZPiu7wg_7so4ZrQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3faabd8fd33so28581845e9.0
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 11:12:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690308772; x=1690913572;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XhcxePtO8lQK0mT+MbSoIUDTZ1JhDNN6V7EwHUlXAzU=;
 b=GJuyoSIga2Gq6/mdCptkO2Q5J+GGDTgsLGOy2I4AwEmec1j4ihjf97gI6Ri/05qxLR
 rdSkAQzNlfujii3BIg87+hKZzMQAmynTg6/jrunzQV7k+r6GQTFn0E/Z56w6YjzSNYc6
 RwCl4frug5PCbBpfjv6tuQoMwrP6KSYXxlPdHqpX/5qFyquNNOtXz5v/37cWqAOQwTYu
 FrQ4ajc5fZ2rsvMABD2CJuSWUAhgYRC5K1P3zuQvVg9a44o3t61qWhWRwiCesV/6VJPJ
 NhSateCE3USLZQ5WJ8pA1ZamniAiipP9cZSxIhavTzzxC9P1763Ybb0vLTD/AFLZz8m4
 UupQ==
X-Gm-Message-State: ABy/qLaNEUKZHA9KE03g2V4a6zzKcxUPCBDjIW9M/xBSw34B+CJV84S1
 JWEYavQXKxqnzj5saL0BnUHUlXGqP0Bu1wmNqsiZC5s93kxXE1umUirMaKl7ZTB0R4/Gq3nxSXc
 wtVciocmPwH9sItQ=
X-Received: by 2002:a7b:c5d6:0:b0:3fb:a2b6:8dfd with SMTP id
 n22-20020a7bc5d6000000b003fba2b68dfdmr9944672wmk.32.1690308771783; 
 Tue, 25 Jul 2023 11:12:51 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHl2yi5ha7G0U8kILcgpOAeTHGBfDZEOeUZWkDsFY1VYP8HWX4qrq1Zq6TB5SuUfGKPkXZrwA==
X-Received: by 2002:a7b:c5d6:0:b0:3fb:a2b6:8dfd with SMTP id
 n22-20020a7bc5d6000000b003fba2b68dfdmr9944648wmk.32.1690308771428; 
 Tue, 25 Jul 2023 11:12:51 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73f:e900:3b0d:87a6:2953:20d1?
 (p200300cbc73fe9003b0d87a6295320d1.dip0.t-ipconnect.de.
 [2003:cb:c73f:e900:3b0d:87a6:2953:20d1])
 by smtp.gmail.com with ESMTPSA id
 l5-20020a05600c1d0500b003fbb1ce274fsm6378049wms.0.2023.07.25.11.12.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Jul 2023 11:12:50 -0700 (PDT)
Message-ID: <b5fd0496-19de-f3ae-a558-2d5c6039a0a7@redhat.com>
Date: Tue, 25 Jul 2023 20:12:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_v6_0/6=5d_Hyper-V_Dynamic_Memory_Protocol_?=
 =?UTF-8?B?ZHJpdmVyIChodi1iYWxsb29uIPCfjojvuI8p?=
Content-Language: en-US
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
References: <cover.1689786474.git.maciej.szmigiero@oracle.com>
 <7b39c541-6aeb-3dc4-2451-67a6b2ff34c6@redhat.com>
 <2212c3f5-954a-84a6-7011-b40bbc54ad23@maciej.szmigiero.name>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <2212c3f5-954a-84a6-7011-b40bbc54ad23@maciej.szmigiero.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

>> That commit would be called something like "pc: Support hv-balloon".
> 
> If I remove the driver from Kconfig in the initial patch then AFAIK
> this initial patch will add a dead driver file that it is not possible
> to build yet, right?

Yes, that's also what we did for virtio-mem:

(bottom to top)

0ed48fd32e pc: Support for virtio-mem-pci
16647a8224 numa: Handle virtio-mem in NUMA stats
2e70874b16 hmp: Handle virtio-mem when printing memory device info
751c7bdd04 MAINTAINERS: Add myself as virtio-mem maintainer
0b9a2443a4 virtio-pci: Proxy for virtio-mem
910b25766b virtio-mem: Paravirtualized memory hot(un)plug

And virtio-pmem:

(bottom to top)

a0a49813f7 pc: Support for virtio-pmem-pci
cae02c3480 numa: Handle virtio-pmem in NUMA stats
d766b22bbd hmp: Handle virtio-pmem when printing memory device infos
adf0748a49 virtio-pci: Proxy for virtio-pmem
9f583bdd47 virtio-pmem: sync linux headers
5f503cd9f3 virtio-pmem: add virtio device


As you're adding all in a single series, that's perfectly fine.

-- 
Cheers,

David / dhildenb


