Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DEE7A2466
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 19:14:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhCOA-0003qN-8U; Fri, 15 Sep 2023 13:13:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qhCO8-0003o7-OC
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 13:13:52 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qhCO6-0002gX-Qb
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 13:13:52 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1c3cbfa40d6so21320805ad.1
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 10:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1694798029; x=1695402829;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cVbbNw8PyhQUyx9DOaY76QmAbaIuGjkVuLIx19MxbXU=;
 b=UuLOKfiyOAeFC6FlpnHJMxOEgDS+MQlLG9zKeRSupnCvq9huKNJEKBftjeNd9qOF0w
 oVylMdXmh6wfFqJw/Ti8HFPJgj/YMOC4wI3YtIhdxBTKySVOXyL0+tyl0mNuhLOOpDap
 C3PAHhXht7nup3GnDdbq8geCUEDVfkFxP1DYTrV2iICISz8DF7W2oYcS+z5lDnBCbfji
 HhmaPXH3fMd5AM1jutZmD8AnGnWVlEc3iYS/Kn8cZirJmkqNbifHQnAY5U0d6vHNREV9
 wjKmaeMpZciZXGFtbZ5TVCq678LPdnbxRg3fhE/FsHzHL5OAZPdKuliuPVXhX31zj1aW
 +IeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694798029; x=1695402829;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cVbbNw8PyhQUyx9DOaY76QmAbaIuGjkVuLIx19MxbXU=;
 b=KL4t117P9xXFnwoAQ0lIn6t0P17WnhAQ5RefJtWHWH2ppV4R3vlRVDWEkk9xLK6b9h
 xg3xhl25PW4ukQ1l7C3f055d+qkjOv4Q6MJcFG6ZUMkOdmqkH3SrvbuoVcqWk/HKIIrF
 mLOrILZaZl4Q/oN/ueb2c0RzNTfIRd4e91jJipUGJXIf4AjBsiHCpKoSjqPge4vqIKql
 qvP4fguEgeVEoOYihJy1rrZt8k8Fusnn40mY5zzhyM2gUasao7B89a4GHUYr1EKaZU7Y
 axsv9GbC+NRwhpVM2ls30nYenZxY56nQf4sIOLgcsNyN3eeDpWS2h9q9uL0fh4O0kroL
 k2Fw==
X-Gm-Message-State: AOJu0YzABVhYgHJsSpU3MHwdz+fHKGh/+c/HQIQ/qphWxsFvf8WByQxF
 MgB8zGkBNs1ZvxM0VbdNfAPQDA==
X-Google-Smtp-Source: AGHT+IEH3cDqX5OolvdSS67VKtQlq97aKarQ0nOzmSnC3hw9ikqDQ/VXnPQBgAhuO/lxll8BZlMYiw==
X-Received: by 2002:a17:903:22c9:b0:1c3:eaa0:dc5 with SMTP id
 y9-20020a17090322c900b001c3eaa00dc5mr2586863plg.26.1694798028980; 
 Fri, 15 Sep 2023 10:13:48 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 f1-20020a170902ab8100b001bb9b87ac95sm3737578plr.103.2023.09.15.10.13.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Sep 2023 10:13:48 -0700 (PDT)
Message-ID: <87e98b7f-3402-4d1a-a1b2-7493aa963a65@daynix.com>
Date: Sat, 16 Sep 2023 02:13:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] elf2dmp: improve Win2022, Win11 and large dumps
Content-Language: en-US
To: Viktor Prutyanov <viktor@daynix.com>, annie.li@oracle.com,
 kkostiuk@redhat.com
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, yan@daynix.com,
 viktor.prutyanov@phystech.edu
References: <20230915170153.10959-1-viktor@daynix.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20230915170153.10959-1-viktor@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::631;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2023/09/16 2:01, Viktor Prutyanov wrote:
> Windows Server 2022 and Windows 11 require more careful kernel PE image
> search and handling of PDB than previous Windows versions.
> Also, improve support of large ELF dump files, dumps with unaligned
> memory ranges and with big number of ranges.
> 
> Viktor Prutyanov (5):
>    elf2dmp: replace PE export name check with PDB name check
>    elf2dmp: introduce physical block alignment
>    elf2dmp: introduce merging of physical memory runs
>    elf2dmp: use Linux mmap with MAP_NORESERVE when possible
>    elf2dmp: rework PDB_STREAM_INDEXES::segments obtaining
> 
>   contrib/elf2dmp/addrspace.c |  31 +++++++-
>   contrib/elf2dmp/addrspace.h |   1 +
>   contrib/elf2dmp/main.c      | 154 ++++++++++++++++++++----------------
>   contrib/elf2dmp/pdb.c       |  15 +---
>   contrib/elf2dmp/pdb.h       |   2 +-
>   contrib/elf2dmp/qemu_elf.c  |  68 +++++++++++++---
>   contrib/elf2dmp/qemu_elf.h  |   2 +
>   7 files changed, 177 insertions(+), 96 deletions(-)
> 

For the whole series:
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

