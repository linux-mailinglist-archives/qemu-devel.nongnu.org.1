Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6446374D1FB
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 11:41:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qInNx-0007F9-8V; Mon, 10 Jul 2023 05:40:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qInNu-0007EZ-6Y
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 05:40:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qInNs-00018i-PZ
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 05:40:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688982043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UpUqVIpSf7y4AhB7iWwrrtsOQGc70aAQ2ye77uAkG3g=;
 b=azKFyVIBX2StqFAUKq+vAKRGGwJcSoO7tAUW6wPJh6Y9opawNNH/jZyEejkyIOpcyi39D9
 gtaGts+hWInpXLelVK8vyRijiMaFelk8/5uZ8aggj1z74EMRkm/G6GLQvrGJBPU1jE54OD
 SR+83g8yZj7AN24j2Z+gvj4hXdHOjRc=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-8Ga_dNGWP9upY0PcIsaFjQ-1; Mon, 10 Jul 2023 05:40:42 -0400
X-MC-Unique: 8Ga_dNGWP9upY0PcIsaFjQ-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-402391ed8ceso56761021cf.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 02:40:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688982042; x=1691574042;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UpUqVIpSf7y4AhB7iWwrrtsOQGc70aAQ2ye77uAkG3g=;
 b=Dp/ajsof1gI7mjgVa4qJ65/F8v9X9urOaPDvdfxb4z89F33Yt4YPXRB2217mkGmxcK
 cf6GpxDWvcKSr0pTvafTkGBBpo/ShJ3EnN06ls3MWVkiqFfCGwXaJffFbJqDIAVv7isL
 16bDFYjA5ypVph/mnxSxM0MgfgG5sUp/GZzGGXkN2FGog7SXU+Yktx/FRFp1sxUGS6JH
 5kx4qW30+cp7kcp8tpJaNbmIfow+l1GcM5w6l9GG7CC96xIe8qZ/HRNL8lOMXmU5QKOz
 ykD1xxEUaGsHVbgUGbWS0OsAkqW3tPNIEOd8ZXmhnG+JVsT+plC62PHbbl1VjbgMXO1c
 0E2w==
X-Gm-Message-State: ABy/qLZhA+rcaDBlQ+Hadtjb6qn5a3vZuqKLE0fHeTv4WZOhTCVAQv+r
 voFf28j4wXBuZfsNVEPm1VBGV2AytHwZ2IVTrRWafRuF93hMbcqc+1TOT5E5g0CPPTOYFO7DhiO
 Ji+Lv0+W6w5aGd8c=
X-Received: by 2002:a05:622a:1456:b0:403:54d7:e33e with SMTP id
 v22-20020a05622a145600b0040354d7e33emr13342367qtx.13.1688982042198; 
 Mon, 10 Jul 2023 02:40:42 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE9iWhN4azwjFTOVMnoEdddZloZvGTncpZmEZzDBbV5MWfO/RXueMVlmmB8A8yu99hRF7Ljxg==
X-Received: by 2002:a05:622a:1456:b0:403:54d7:e33e with SMTP id
 v22-20020a05622a145600b0040354d7e33emr13342356qtx.13.1688982041996; 
 Mon, 10 Jul 2023 02:40:41 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-179-116.web.vodafone.de.
 [109.43.179.116]) by smtp.gmail.com with ESMTPSA id
 g10-20020ac870ca000000b00403a2e88d01sm2735400qtp.40.2023.07.10.02.40.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Jul 2023 02:40:41 -0700 (PDT)
Message-ID: <3a341f87-c7eb-b971-3d98-364a180e6449@redhat.com>
Date: Mon, 10 Jul 2023 11:40:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 9/9] tests/qtest: massively speed up migration-test
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20230531132400.1129576-1-berrange@redhat.com>
 <20230531132400.1129576-10-berrange@redhat.com> <ZHi9OQz8PGuHMPpN@x1n>
 <87353ardol.fsf@secure.mitica> <ZHktL1tZwSmT+Pcn@x1n>
 <ZKvQ5+m1luumzWEQ@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <ZKvQ5+m1luumzWEQ@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 10/07/2023 11.35, Daniel P. Berrangé wrote:
> On Thu, Jun 01, 2023 at 07:43:43PM -0400, Peter Xu wrote:
>> On Fri, Jun 02, 2023 at 01:00:10AM +0200, Juan Quintela wrote:
>>> That was basically my idea and that is why I am holding the last two
>>> patches and see if I can came with something in the next couple of days.
>>
>> Ah! ...
>>
>> If you haven't started, please hold off for one day.  I'll see whether I
>> can post mine tomorrow.
> 
> 5 weeks later, and we've still not got a fix merged, and it is soft
> freeze tomorrow.
> 
> Since this patch works, could we please consider merging this now. It is
> a simple revert at a later once when Peter's desired better solution is
> finally ready, unless Peter's series can be submitted for soft freeze
> merge today ?

I agree, I'll queue this qtest patch here for my PR-before-softfreeze now - 
if Peter's work is ready to get merged via the migration tree, this patch 
here can be easily reverted again.

  Thomas


