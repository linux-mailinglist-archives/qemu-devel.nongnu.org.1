Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 862E08CFF22
	for <lists+qemu-devel@lfdr.de>; Mon, 27 May 2024 13:38:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBYfY-0003jy-4h; Mon, 27 May 2024 07:37:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sBYfN-0003bd-57
 for qemu-devel@nongnu.org; Mon, 27 May 2024 07:37:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sBYfK-0002Sq-R6
 for qemu-devel@nongnu.org; Mon, 27 May 2024 07:37:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716809838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=UQaY9zVw0r1cwX34xp+AfF6h6mDwEgHOfbPS3l6Pc2Q=;
 b=X8dJIE875y4AsKTeqogDv3LYVfr81vDsF1kCrkFA80xlUPVpqhSr/EeV1R24aBallpP/Pi
 BQew5otCvPfa7vTHZoCDeBx7sskqvRrQfaFLC50n79mN+RvehgT/KwdQlsWbq3E/XyNiFV
 RSAgrVjxSnt+EFhYtdGXdZl1zPRPeug=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-ScU9wxz8N4KaT-6xkRhXRw-1; Mon, 27 May 2024 07:37:16 -0400
X-MC-Unique: ScU9wxz8N4KaT-6xkRhXRw-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-794ab2615f4so427844285a.3
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 04:37:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716809836; x=1717414636;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UQaY9zVw0r1cwX34xp+AfF6h6mDwEgHOfbPS3l6Pc2Q=;
 b=NwriHlSF8Lj2RSFgwmaHHghpwPA2nzi4ou1ldyxaCw6teCcgCRx2NaosuU6T7HJ2T1
 fNslMop+buOZ6oNRAAZwvrFYlkLVWdZ25K/FBYa2UiOJfGj1+zO3zMSXVDku6kPNyviC
 UoDe2fdsPQsmdhkxfdX4cNmdS5pMTTYJEVR6m5PoJFHOpOSS83B684xh0qRYBmttdWR5
 r4/O/skxoEgbNBRr/Vfincs3fHrGxU9Ll+ryNHsQIXseax6tWeIeUbeO90IuLheQRx5E
 0GAesG+A6sx9Vk94qQr+NYDwRLYyvf2dH6ROrFpYaS8CmX5BWzBL4bKdxlS0EfL9muur
 JexA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1yKOj91vTS0xe+K5ZuS21iUAYLhzbaj/oPBHh6vUXHpzrZ8b3HBS0mQmRmGUoqcFdhsvBVipdLaJ3O+Ta/O6JNtzp/lw=
X-Gm-Message-State: AOJu0YwiHs0iBWlr0uGbX7/yGjUNWPnJDd08BIzAgFUWRiomJwVRJMaN
 ltDf5JYZJWEcuh6T7lxzHDBSQgZUzeS6bB5i6yt7I3KlDjvlrbKvpoWLrZlL2E/MPRIB3qdQ+wG
 0emg1htE2Pifc48yMv9/s2IhBxLwFjQtEI3qxzLFkqJiy7Fn3yDPt
X-Received: by 2002:a05:620a:70ed:b0:794:ad5f:1918 with SMTP id
 af79cd13be357-794ad5f1a39mr842177585a.38.1716809836339; 
 Mon, 27 May 2024 04:37:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBxYECfDTAUbBl567oIJdQAWGMFdnvGa+rWxnt+7oSa9jiqJuUGvstzGwve9DneTOhQw0ZLw==
X-Received: by 2002:a05:620a:70ed:b0:794:ad5f:1918 with SMTP id
 af79cd13be357-794ad5f1a39mr842175885a.38.1716809835986; 
 Mon, 27 May 2024 04:37:15 -0700 (PDT)
Received: from [192.168.0.4] (ip-109-43-179-90.web.vodafone.de.
 [109.43.179.90]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-794abcc0f0fsm291703385a.38.2024.05.27.04.37.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 May 2024 04:37:15 -0700 (PDT)
Message-ID: <19dc6fa4-ea43-4518-8cfd-8d6964b797e6@redhat.com>
Date: Mon, 27 May 2024 13:37:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] tests/qtest/migration-test: Quieten ppc64 QEMU
 warnigns
To: Nicholas Piggin <npiggin@gmail.com>, Fabiano Rosas <farosas@suse.de>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
References: <20240525031330.196609-1-npiggin@gmail.com>
 <20240525031330.196609-2-npiggin@gmail.com>
 <98ec8131-2b81-4e40-abfc-d5fbcf1b41d8@redhat.com>
 <D1KE2R5951UL.10T7UNCCZZPBU@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <D1KE2R5951UL.10T7UNCCZZPBU@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 27/05/2024 13.26, Nicholas Piggin wrote:
> On Mon May 27, 2024 at 5:32 PM AEST, Thomas Huth wrote:
>> On 25/05/2024 05.13, Nicholas Piggin wrote:
>>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>>> ---
>>>    tests/qtest/migration-test.c | 4 +++-
>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
>>> index b7e3406471..c13535c37d 100644
>>> --- a/tests/qtest/migration-test.c
>>> +++ b/tests/qtest/migration-test.c
>>> @@ -21,6 +21,7 @@
>>>    #include "chardev/char.h"
>>>    #include "crypto/tlscredspsk.h"
>>>    #include "qapi/qmp/qlist.h"
>>> +#include "libqos/libqos-spapr.h"
>>
>> It's a little bit unfortunate to include a libqos header in a non-qos test
>> ... so in case you respin, maybe add a comment at the end of the line like:
>>
>>     /* just for PSERIES_DEFAULT_CAPABILITIES */
>>
>> ?
> 
> Same as other uses of it by the looks. Could just put it in a new
> header in tests/qtest/ppc-util.h or something?

Yes, that would be cleaner, indeed.

  Thanks,
   Thomas



