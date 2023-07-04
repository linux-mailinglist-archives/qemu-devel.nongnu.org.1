Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17645746AD9
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 09:41:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGaeg-00023m-RZ; Tue, 04 Jul 2023 03:40:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qGaeb-0001wS-LS
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 03:40:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qGaea-0003D7-63
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 03:40:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688456451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MUF3yq6cQ/cmEuCxUrFlbWyiQBJGd0s7fU90RJbAKwI=;
 b=FAqI2kfatoMl0VxIfCz3Ej21937tljh1fj/gktiAx4bquT6vQ2X1lz9bXrJ4t1Vv+ZbsHf
 GGd0AEAwcNm6SkkBDdsR8SG3j9QZgElW+BpbPrORBMS1qb9Pc3/4HcJX2W+JAzYsahfwn2
 WgNTEqyrKkUz01dAIMAb1voynWX4izs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-LhilAl0oMzWwzmh8QzDTxA-1; Tue, 04 Jul 2023 03:40:46 -0400
X-MC-Unique: LhilAl0oMzWwzmh8QzDTxA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f42bcef2acso30671815e9.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 00:40:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688456443; x=1691048443;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MUF3yq6cQ/cmEuCxUrFlbWyiQBJGd0s7fU90RJbAKwI=;
 b=YQkc7CkEQAD5t7eizoLqeSGHUV/5Xcb6B4I5D5P73ylHGrq5xe+61SdLNJcG8/TDpb
 eiBWaNO4+7yq25aQOHE/0dK3Ks+vZfK8nHrE7BKis7ouBU0q3aLhlv9FDjSmIULqQQQ8
 Znlzgc6Rg8d2O9BNekQ1TfS1II+ydbvzHeGyxaaH5ktTSZM9FmVEcznJy3kAl4z7naGZ
 5JYWwXp41KTuejlKDlMi/hGsffiIweFNeeLjvQSEifll7v+xhxgXUfBJ/k+gJXCRB1gP
 6a5Xtm4fm86PD+H/A0eeooHgj3o9NyM/3QoN9/wOFaFyLmdWyLwp1AvZv1UVAR8ib6op
 W1OA==
X-Gm-Message-State: ABy/qLZRiugXtsVlV5UhOpznKGZy6cCFQ0MDt3tdB/d1V6rPgYSAhjPS
 ZWPvFW7zTeOAcvuQPx3vRE8TGqv8xp6vhjJU9lpr2XK5xvazazixMcgN3qu9l85aprgYQ1iKu1j
 PBWhGaGj+8KeodJk=
X-Received: by 2002:a1c:f712:0:b0:3fb:dbd0:a7ea with SMTP id
 v18-20020a1cf712000000b003fbdbd0a7eamr3476814wmh.37.1688456443517; 
 Tue, 04 Jul 2023 00:40:43 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFts1ykJ+sADZS8ybcJ8Qr7Lcd6cs7+2sEBqLJNtSczKdpBr5zSSqxKTHbNXJFz6lrtCsH7Yg==
X-Received: by 2002:a1c:f712:0:b0:3fb:dbd0:a7ea with SMTP id
 v18-20020a1cf712000000b003fbdbd0a7eamr3476796wmh.37.1688456443265; 
 Tue, 04 Jul 2023 00:40:43 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f30:5a00:b30d:e6bc:74c3:d6f2?
 (p200300d82f305a00b30de6bc74c3d6f2.dip0.t-ipconnect.de.
 [2003:d8:2f30:5a00:b30d:e6bc:74c3:d6f2])
 by smtp.gmail.com with ESMTPSA id
 r3-20020adfda43000000b0030ae3a6be4asm27673303wrl.72.2023.07.04.00.40.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jul 2023 00:40:42 -0700 (PDT)
Message-ID: <46e1acff-a9ad-3c5a-41f8-cd4a68d00d8f@redhat.com>
Date: Tue, 4 Jul 2023 09:40:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 04/12] target/s390x: Fix MVCRL with a large value in R0
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>, 
 Richard Henderson <richard.henderson@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, qemu-stable@nongnu.org
References: <20230703155801.179167-1-iii@linux.ibm.com>
 <20230703155801.179167-5-iii@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230703155801.179167-5-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
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

On 03.07.23 17:50, Ilya Leoshkevich wrote:
> Using a large R0 causes an assertion error:
> 
>      qemu-s390x: target/s390x/tcg/mem_helper.c:183: access_prepare_nf: Assertion `size > 0 && size <= 4096' failed.
> 
> Even though PoP explicitly advises against using more than 8 bits for the
> size, an emulator crash is never a good thing.
> 
> Fix by truncating the size to 8 bits.
> 
> Fixes: ea0a1053e276 ("s390x/tcg: Implement Miscellaneous-Instruction-Extensions Facility 3 for the s390x")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


