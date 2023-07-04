Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BB5746B0A
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 09:48:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGalm-0004pL-DE; Tue, 04 Jul 2023 03:48:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qGalh-0004ot-QQ
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 03:48:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qGalf-0004gW-Fe
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 03:48:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688456890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bUj8pwC+ELb4ZPUmkFatzcdwHhzQ76wB9cWbwHZegZg=;
 b=cgktHIVRCtXCyvzRnJhnS3TZ72SkqCqUE71X31beBWS16BRpSReOw/UPOLzsGak/oR72qR
 BcSHyFObPqLtiq38RSir2cnMmTC1rOwnc0/K9iOsg+jUcYGJx0123dvgZT0COVptLsX46N
 gT7NjghLDSkpd0fKXqxaXdwmQPqrd2g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-yTwxT3zpPeWtdjrRaXY49w-1; Tue, 04 Jul 2023 03:48:09 -0400
X-MC-Unique: yTwxT3zpPeWtdjrRaXY49w-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f810b4903fso32029995e9.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 00:48:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688456888; x=1691048888;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bUj8pwC+ELb4ZPUmkFatzcdwHhzQ76wB9cWbwHZegZg=;
 b=QrV0LxJt/dTddbJAZrDkDJS1rXF4VEww2cGpjiibggLHsUW/kMtSEvDfJs99TOQUeL
 KpA77K7plZ2kgsbsyAIlRsRSPozmmPpANpFgnZ1fPvd8BYEJ7nVwZ5Ucc0pJ4aBmhR0V
 DuaBcS5Ahc4+aY6NowvrBRA1OquThhXUmtf1CYcrlAd5qCwo+Qe8315RiQxoNXeXKCzz
 p/KblmKsesSzljxEIh1UKdjDaXEt2f11+ioG/GORe0JC0DQub4cCLLTTIe1x5XgOVcS/
 HtwdVKwB4pY4v/eoyOdRy1I+ldl7BI/zKJIt8fFC4RJK8RQ3Xp0Itatk9oMqTXmH4HDS
 tDZA==
X-Gm-Message-State: AC+VfDw4kW1a5ldjvcqYtWltOGvpFsucAsP0l01x9ff3JbX4fMlFh6cq
 QyCBss1t5eWT+Vga4hUPEqm3Mkp58fQKcgmkIUNR3GPuAWbaT3VTEM6CD22rDw2/KUxFa8kLXN1
 FTEmaaNnNdfbJlII=
X-Received: by 2002:a7b:c4cd:0:b0:3f5:146a:c79d with SMTP id
 g13-20020a7bc4cd000000b003f5146ac79dmr10781198wmk.15.1688456888060; 
 Tue, 04 Jul 2023 00:48:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4QoFFnkuKHwj00UCWQjHHoxSJKC0Arqb+UqvhRsUWWTQEX6nvRW/uvnMKgmKGZ7RXuL5pm6g==
X-Received: by 2002:a7b:c4cd:0:b0:3f5:146a:c79d with SMTP id
 g13-20020a7bc4cd000000b003f5146ac79dmr10781187wmk.15.1688456887766; 
 Tue, 04 Jul 2023 00:48:07 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f30:5a00:b30d:e6bc:74c3:d6f2?
 (p200300d82f305a00b30de6bc74c3d6f2.dip0.t-ipconnect.de.
 [2003:d8:2f30:5a00:b30d:e6bc:74c3:d6f2])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a1cf00a000000b003f8fb02c413sm29346236wmb.8.2023.07.04.00.48.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jul 2023 00:48:07 -0700 (PDT)
Message-ID: <940d3bf4-c57f-7e44-eeb8-7b4a04051945@redhat.com>
Date: Tue, 4 Jul 2023 09:48:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 01/12] linux-user: elfload: Add more initial s390x PSW bits
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>, 
 Richard Henderson <richard.henderson@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
References: <20230703155801.179167-1-iii@linux.ibm.com>
 <20230703155801.179167-2-iii@linux.ibm.com>
 <e53ccd03-1109-7868-4302-6e578aa503c8@redhat.com>
 <f4fd796869a3dd189084b52c12b8ba80e69113b0.camel@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <f4fd796869a3dd189084b52c12b8ba80e69113b0.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 04.07.23 09:40, Ilya Leoshkevich wrote:
> On Tue, 2023-07-04 at 09:32 +0200, David Hildenbrand wrote:
>> On 03.07.23 17:50, Ilya Leoshkevich wrote:
>>> Make the PSW look more similar to the real s390x userspace PSW.
>>> Except for being there, the newly added bits should not affect the
>>> userspace code execution.
>>
>> What's the purpose of this then? Required for follow-up patches?
> 
> That's required for the EPSW test.
> I could, of course, mask out the bits that are not emulated in the
> test, but I thought it was better to make the emulation closer to
> reality, if only for cosmetic purposes.

Thanks

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


