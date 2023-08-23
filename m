Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A57C07854D0
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 12:04:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYki3-0007rj-2n; Wed, 23 Aug 2023 06:03:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qYki0-0007r2-RG
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 06:03:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qYkhz-0005pA-A9
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 06:03:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692785006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=367LBIjZwxBsGDxJ42Wl9TCL+qHDRPZQ9J0cGHzHE+w=;
 b=d3A6LR9IexR9rlVHnAaj6dm74Wz+UhALrHXTebUDL6NvQE2FSWg3MnYvaQBzvm7iQRRe5L
 HZFQlSA8Dq65U73Tt6fNlANO2sfEc0S0otRJdob1tP1mSuGjodCKc4v35HkBFRy2RTAwM5
 LheNx5PfBAaFQjvVUcm49q95lIOtNPQ=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-qmoQTA42PeWJ7VuQwYcV4g-1; Wed, 23 Aug 2023 06:03:24 -0400
X-MC-Unique: qmoQTA42PeWJ7VuQwYcV4g-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2ba1949656bso57061681fa.0
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 03:03:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692785003; x=1693389803;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=367LBIjZwxBsGDxJ42Wl9TCL+qHDRPZQ9J0cGHzHE+w=;
 b=MPMw5FqU9E7Ex3TciAS41LbcDG0i2dDapeTwZYcypfYbNRxa4YAeyR0E384suHpRL7
 wFiGzd62ddlK6X6POgprxZCmUJkpFawUBSfHZQc1ArL1I794skOwgI8cqzn27tnvZ/KV
 WYIwQsj1d5BE7YsuQeRLTDx8om6To9pky4IP+MOKQO0I9utRz1gnY1EBsJxx2JCXOMWL
 nSv0tarX7a3bE6hKS2m/NILXgmimIpfKmbh/DLfST6FVIY0z/AHuVmSRdvw+n6NFxFMP
 Hrzbm/Q+ic2a9tPv/kYNNJDXLG/lMecVGp9QeAdz3MbO/9zctmAPPHcqb0CMOhWMQ+Qu
 tQZA==
X-Gm-Message-State: AOJu0YzcQtO0gJz8E7npDZUHWODzvF33yj6fuGf/yNeO7/C97oMcHlep
 tRWdFyXwxF1bMMQ92ooysIjTLBFhuYDgoOMrI9HjLzPTvR+AiwW8UuGbxcWYvsqYWdFgU10t/3b
 tQENrt5SKimbMdtc=
X-Received: by 2002:a2e:9943:0:b0:2b6:eb5a:d377 with SMTP id
 r3-20020a2e9943000000b002b6eb5ad377mr9823159ljj.5.1692785003355; 
 Wed, 23 Aug 2023 03:03:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOd6y+CEa/429jUkQWa9pdG8ybR3P5Czsj5ixmZ63fVe6JSrZzANLOTWhz8MkDw1zqWI4rhg==
X-Received: by 2002:a2e:9943:0:b0:2b6:eb5a:d377 with SMTP id
 r3-20020a2e9943000000b002b6eb5ad377mr9823141ljj.5.1692785002917; 
 Wed, 23 Aug 2023 03:03:22 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70c:e700:4d5c:81e2:253e:e397?
 (p200300cbc70ce7004d5c81e2253ee397.dip0.t-ipconnect.de.
 [2003:cb:c70c:e700:4d5c:81e2:253e:e397])
 by smtp.gmail.com with ESMTPSA id
 m25-20020a7bcb99000000b003fee7b67f67sm13119692wmi.31.2023.08.23.03.03.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Aug 2023 03:03:22 -0700 (PDT)
Message-ID: <ebc6ebe0-ef32-6b0b-5612-f2d2ad466f11@redhat.com>
Date: Wed, 23 Aug 2023 12:03:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/3] target/s390x: Fix the "ignored match" case in VSTRS
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Claudio Fontana <cfontana@suse.de>, qemu-stable@nongnu.org
References: <20230804233748.218935-1-iii@linux.ibm.com>
 <20230804233748.218935-3-iii@linux.ibm.com>
 <5ea25092-b362-0587-5ad0-f3883cc86ba1@redhat.com>
 <558f087ae3f7e13a202f1e7ddda22e5996066269.camel@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <558f087ae3f7e13a202f1e7ddda22e5996066269.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.767, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 07.08.23 10:10, Ilya Leoshkevich wrote:
> On Sat, 2023-08-05 at 10:02 +0200, David Hildenbrand wrote:
>> On 05.08.23 01:03, Ilya Leoshkevich wrote:
>>> Currently the emulation of VSTRS recognizes partial matches in
>>> presence
>>> of \0 in the haystack, which, according to PoP, is not correct:
>>>
>>>       If the ZS flag is one and a zero byte was detected
>>>       in the second operand, then there can not be a
>>>       partial match ...
>>>
>>> Add a check for this. While at it, fold a number of explicitly
>>> handled
>>> special cases into the generic logic.
>>
>> Can we split that off? Or doesn't it make sense to split it off after
>> fixing the issue?
> 
> I could do this if this is important, e.g., for stable, but I came to
> the conclusion that I needed to get rid of the special cases after I
> had to add the new check to more than one place.

Okay, so let's keep it as is.

Fortunately you heavily test that code! :)

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


