Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E59979A34F
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 08:08:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfa4h-00055V-UC; Mon, 11 Sep 2023 02:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qfa4W-000551-Be
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 02:06:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qfa4S-0006k7-9r
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 02:06:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694412410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Aypap0OXnHDH/WJeJ9gS/LtqdHDqBfOJ7RB5Czc83R0=;
 b=XA8WFGu0SSv5JXwT6m6fhvqN/9KcxDK1D8jeI3cFN2v3b9RNnsADiDw+7PXBKzktHsKNop
 NZsumOEvz4QieJQrsVoZl7XGsv7oLvhnpGnBhe3Da51/Trlr1AuMdYXCzHGx7x+7OrojgU
 L7rAuyatPvY/3gkfTtWMpik1tNjkPSc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-Cgz7iEY3PvCAIwph8wee9g-1; Mon, 11 Sep 2023 02:06:48 -0400
X-MC-Unique: Cgz7iEY3PvCAIwph8wee9g-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-401be705672so31372705e9.2
 for <qemu-devel@nongnu.org>; Sun, 10 Sep 2023 23:06:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694412407; x=1695017207;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Aypap0OXnHDH/WJeJ9gS/LtqdHDqBfOJ7RB5Czc83R0=;
 b=FJaXxa7SczQmMBUtJ/95r8MBf6u+q2ux77cf35+koaKr3hc8V6C25G2rRDpHBS/Zqy
 oiORJ9r+y1S+mbh9LKja6IIiKKysq7cEIwOIkHt7RH8JNOfIC4ztuT7OQUB25TETDw9r
 Ifmedn5rlWNcRBe86acVvtJBeCQPP8fUtU1qq0PRq8Twn9My2J509t9pQ8JgKndjHJwq
 uXWuEMbjY+9OkYkwO1+Jh9TP1VkPbtCi2WSPiNchFLkoOHFy7akOEv9768ccG25L76eD
 hX3OoJ+aQKD/iHeD+bgd660p2+vT7VgPKNt0yWRgXkK7d5KmalqU8mKbYjk0arnDyBiT
 BJWA==
X-Gm-Message-State: AOJu0YySTz9VsYfbWBTr9Rn40pfTMCuGBUn4wi3wAsOI34Whlybofb0I
 aMfR03t9KwSMvsydoVbSnOqj7JQ6eLZT2FM1sHnryzHVCtOEdXKQ2Phg11ZlgHSGC7vY/Ex/nvX
 5RaSnCkHK7l2dlYM=
X-Received: by 2002:a7b:c7c9:0:b0:401:bf56:8ba6 with SMTP id
 z9-20020a7bc7c9000000b00401bf568ba6mr7026939wmk.28.1694412407530; 
 Sun, 10 Sep 2023 23:06:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFf1Jkum20QdGgIxjr/VbKtGOrhaydm3nepaiNpaMSi7LB4FjSFFPZ1fyHTq9+yU8/Hln9K6A==
X-Received: by 2002:a7b:c7c9:0:b0:401:bf56:8ba6 with SMTP id
 z9-20020a7bc7c9000000b00401bf568ba6mr7026931wmk.28.1694412407216; 
 Sun, 10 Sep 2023 23:06:47 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-178-150.web.vodafone.de.
 [109.43.178.150]) by smtp.gmail.com with ESMTPSA id
 f7-20020a7bcd07000000b00401c595fcc7sm12156709wmj.11.2023.09.10.23.06.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 10 Sep 2023 23:06:44 -0700 (PDT)
Message-ID: <cd09ca4b-b0a6-c8f4-a752-b3494cffa2b8@redhat.com>
Date: Mon, 11 Sep 2023 08:06:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH for stable-7.2 only] gitlab-ci: check-dco.py: switch from
 master to stable-7.2 branch
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>
References: <20230910073009.2714174-1-mjt@tls.msk.ru>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230910073009.2714174-1-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

On 10/09/2023 09.30, Michael Tokarev wrote:
> There's one commit, tagged v7.2.2, without Signed-off-by line.
> Due to this, check-dco test always fail on 7.2.  Since this is
> a stable branch with almost all commits coming from master
> already with S-o-b (except of the version bumps and very rare
> stable-specific commits), and v7.2.2 is already cast in stone,
> let's base the check on stable-7.2 branch (with its last version)
> instead of master branch.  This way, staging-7.2 will be checked
> against stable-7.2, but stable-7.2 itself will not be checked
> anymore, - so we can catch errors during stable preparations.
> 
> Note: this is a change specific to stable-7.2 branch/series, it
> is not supposed to be in master.
> 
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>   .gitlab-ci.d/check-dco.py | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/.gitlab-ci.d/check-dco.py b/.gitlab-ci.d/check-dco.py
> index 632c8bcce8..b929571eed 100755
> --- a/.gitlab-ci.d/check-dco.py
> +++ b/.gitlab-ci.d/check-dco.py
> @@ -20,12 +20,12 @@
>   repourl = "https://gitlab.com/%s/%s.git" % (namespace, reponame)
>   
>   subprocess.check_call(["git", "remote", "add", "check-dco", repourl])
> -subprocess.check_call(["git", "fetch", "check-dco", "master"],
> +subprocess.check_call(["git", "fetch", "check-dco", "stable-7.2"],
>                         stdout=subprocess.DEVNULL,
>                         stderr=subprocess.DEVNULL)
>   
>   ancestor = subprocess.check_output(["git", "merge-base",
> -                                    "check-dco/master", "HEAD"],
> +                                    "check-dco/stable-7.2", "HEAD"],
>                                      universal_newlines=True)
>   
>   ancestor = ancestor.strip()
> @@ -85,7 +85,7 @@
>   
>   To bulk update all commits on current branch "git rebase" can be used:
>   
> -  git rebase -i master -x 'git commit --amend --no-edit -s'
> +  git rebase -i stable-7.2 -x 'git commit --amend --no-edit -s'
>   
>   """)
>   

Reviewed-by: Thomas Huth <thuth@redhat.com>


