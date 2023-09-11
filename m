Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D6D79A4D8
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 09:43:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfbYb-0000Ug-AI; Mon, 11 Sep 2023 03:42:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qfbYa-0000UY-C7
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 03:42:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qfbYY-0006Wq-4C
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 03:42:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694418121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pC9UGavsU+vRzi6y/GuzeJfyCMJ0NnJ2yBFs5PZzfFQ=;
 b=Q0KbEE5IdBh4ZypYuk0fcTGnDyBOkrYnrnbj9nLDxbbxyjLaokCluDU30Yv6puTIQUfkrb
 /ks17B/uhxCxG48M2WnW2WbR9B/PubY2Uc57lqqO47/+1xoEjBcHJgmrBcuYzKBXaAIN2M
 CVLx6ZtJ0GHUuILZuPhKlG4W+6vIKMw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-HaGGW8cuPTu_WYFm7tyU9g-1; Mon, 11 Sep 2023 03:41:59 -0400
X-MC-Unique: HaGGW8cuPTu_WYFm7tyU9g-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-31f3eaa5c5eso2716385f8f.3
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 00:41:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694418118; x=1695022918;
 h=content-transfer-encoding:in-reply-to:organization:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pC9UGavsU+vRzi6y/GuzeJfyCMJ0NnJ2yBFs5PZzfFQ=;
 b=YNfDaIVR3FsYOJTo122iAFS96MTcPUx0z+7PtKfXRf/RDqsbUca/r/tpjbLanrXmeo
 7nqE6Sh/JNvZu2KxZAOmNlW1Uvj7HDdZqUK4uusIrNnk1q1rvuoLXGxV/miEMkyhltGu
 ZDjchIsOCT9ly7JXRU4rc2qJ/jRoaGtaMuO1ZzDLgqrV4FYFRNmMj4BWBptgmmWsfYHH
 vg578/+hVVYXdC07IYhDPozQDm28YK0zgRPLGATDmwMoLFMArQqCfSGlqcLyHXw+UpSQ
 y+7/oQ3z181tA7850skejB9TXlnBmBnA8vTkfH99XbryDtIikQkiDBg/8fY3gaWjOrtS
 RoNg==
X-Gm-Message-State: AOJu0YwoE3xkuL1Z9quH13yjaH7akeZ+QkJajUqI0zVl4r2MwEFrq9fz
 eDYJoHl/UPtOr8gywZPhpbW0Kwcqhxfgh7HmItj3c/Ry4lX0TG7gIX2hg1cBoo/WGA/k8303eyi
 sY/rWW0GrF+eKXV1uQjX2SqAmASlbyQ6B0VN8A+Qn8HQMyyptNsvSk3O1nBcSlUym93uI3hk=
X-Received: by 2002:a5d:47cb:0:b0:31f:a1c5:7e7c with SMTP id
 o11-20020a5d47cb000000b0031fa1c57e7cmr3161403wrc.12.1694418118652; 
 Mon, 11 Sep 2023 00:41:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGC9ReLfLNtUK5KOW5+GKni95JLml59BP4tLfWgVLOdehm4bIdMGF+tRECzknMVFA2/qp2jtQ==
X-Received: by 2002:a5d:47cb:0:b0:31f:a1c5:7e7c with SMTP id
 o11-20020a5d47cb000000b0031fa1c57e7cmr3161369wrc.12.1694418118198; 
 Mon, 11 Sep 2023 00:41:58 -0700 (PDT)
Received: from ?IPV6:2003:cb:c743:5500:a9bd:94ab:74e9:782f?
 (p200300cbc7435500a9bd94ab74e9782f.dip0.t-ipconnect.de.
 [2003:cb:c743:5500:a9bd:94ab:74e9:782f])
 by smtp.gmail.com with ESMTPSA id
 v5-20020a5d43c5000000b003180fdf5589sm9327752wrr.6.2023.09.11.00.41.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Sep 2023 00:41:57 -0700 (PDT)
Message-ID: <80f72340-319b-852e-d6f8-e48528081556@redhat.com>
Date: Mon, 11 Sep 2023 09:41:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 00/11] memory-backend-file related improvements and VM
 templating support
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Thiner Logoer <logoerthiner1@163.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, Greg Kurz <groug@kaod.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20230906120503.359863-1-david@redhat.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230906120503.359863-1-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 06.09.23 14:04, David Hildenbrand wrote:
> If there are no more comments, I'll queue this myself soon.

Queued to

https://github.com/davidhildenbrand/qemu.git mem-next

-- 
Cheers,

David / dhildenb


