Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C16E88A2CF4
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Apr 2024 12:59:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvEcD-0004SO-Lj; Fri, 12 Apr 2024 06:58:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rvEcB-0004Oq-2q
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 06:58:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rvEc9-000334-Fi
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 06:58:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712919516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1+2b+f0iWASNOd6dD7LVRc4cwtgoyesZL8zCastxObM=;
 b=WT7Afe0WCdqGLo4/a5hnEi9vfB0wganPw7b6RepKCHcfa2RwnR89y3UHZRglbzL6jbs1gL
 Xhw7nf6uJPvRzkmyFdVE3fbSULfGHTifdSGljDp6OBbnGxbN1h54O2ixcw2CJ8HhzUTr5N
 qEQt1XxIhlsPn+u7eJfff6rwY1Wq3NQ=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-75NzIvtXOpCYpJ4Z0n15NA-1; Fri, 12 Apr 2024 06:58:32 -0400
X-MC-Unique: 75NzIvtXOpCYpJ4Z0n15NA-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-617c8ff16fdso13973337b3.2
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 03:58:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712919512; x=1713524312;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1+2b+f0iWASNOd6dD7LVRc4cwtgoyesZL8zCastxObM=;
 b=sN8g43yTksWsMQfdjilmokoZKz1M6JhkX7SNR0LKMA+UKckMPJHK68yoYCfp/nnTv/
 To3kHApQ4Ol6WxS1UWqN1CF7Mv/c7fiKACYm1jax9qD/LzTtFdfcbP6gVKDA0c3+3dBx
 ATgqvNhiIFFm2uauFripABRkDjMpVol240rejhVmsq74hKKnuKClfA/f5nNnYtt+YmW5
 v41frQa+DZ/3CXssoWD918LcJWLgbvPZAyhBG8iulEUN6SMQa5kx4KdCJ7y8l1b2KL2E
 +xz6VXdIibcv84a4vV5eWKL2Kv7gLrhrzbFxJcz4SrPImtasDkxfUN9WM3fqZMUuWS2h
 7cNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDjhj39zVOMi8YwbGhtGYFnC+qHG0paEgnLfcL80kEfERmvROP2+HIGq7CgSUiixNxxV3GY6nbsbc7HHMIBsz+giH0WRc=
X-Gm-Message-State: AOJu0YxlDYjZvJ3edfVTjHfWNZR5DDhCQbScaNjKeZfuG5lVkvl0ov54
 4poYRYTYC4ZKTtwDuxPPr3ou3+/Q5lggljmBdgo7XLQEQNmwxkbE4cc6+U/ruzAtxl4Mn2REAyg
 FgkBepe458erBStCkI3XY0OUwY3cSw/A2sgqpoZpQ+mcBBxFMyjYZ
X-Received: by 2002:a0d:db52:0:b0:618:505:2f08 with SMTP id
 d79-20020a0ddb52000000b0061805052f08mr2130216ywe.32.1712919511884; 
 Fri, 12 Apr 2024 03:58:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfA4rXuCawRpA11RCC8jtuQYq4PlZY21mAaf47p5LZn8Qh6RVCdcR6YROLrNw+xiWaDZiFPQ==
X-Received: by 2002:a0d:db52:0:b0:618:505:2f08 with SMTP id
 d79-20020a0ddb52000000b0061805052f08mr2130199ywe.32.1712919511506; 
 Fri, 12 Apr 2024 03:58:31 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-43-179-142.web.vodafone.de.
 [109.43.179.142]) by smtp.gmail.com with ESMTPSA id
 b20-20020a05620a0cd400b0078d6a0d5728sm2265432qkj.29.2024.04.12.03.58.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Apr 2024 03:58:31 -0700 (PDT)
Message-ID: <7762cbe9-7cf0-4c98-8b3b-5e347966a81d@redhat.com>
Date: Fri, 12 Apr 2024 12:58:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.1 4/9] Bump minimum glib version to v2.66
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Lieven <pl@kamp.de>, "Richard W.M. Jones" <rjones@redhat.com>,
 qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Konstantin Kostiuk <kkostiuk@redhat.com>,
 qemu-block@nongnu.org
References: <20240328140607.2433889-1-thuth@redhat.com>
 <20240328140607.2433889-5-thuth@redhat.com>
 <CABgObfYb-b7vaNaaESO-K_Q1vWomUaSNudmdA6JX6sj6mVkAFQ@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CABgObfYb-b7vaNaaESO-K_Q1vWomUaSNudmdA6JX6sj6mVkAFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.103,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 12/04/2024 12.16, Paolo Bonzini wrote:
> On Thu, Mar 28, 2024 at 3:06 PM Thomas Huth <thuth@redhat.com> wrote:
>>
>> Now that we dropped support for CentOS 8 and Ubuntu 20.04, we can
>> look into bumping the glib version to a new minimum for further
>> clean-ups. According to repology.org, available versions are:
>>
>>   CentOS Stream 9:       2.66.7
>>   Debian 11:             2.66.8
>>   Fedora 38:             2.74.1
>>   Freebsd:               2.78.4
>>   Homebrew:              2.80.0
>>   Openbsd:               2.78.4
>>   OpenSuse leap 15.5:    2.70.5
>>   pkgsrc_current:        2.78.4
>>   Ubuntu 22.04:          2.72.1
>>
>> Thus it should be safe to bump the minimum glib version to 2.66 now.
>> Version 2.66 comes with new functions for URI parsing which will
>> allow further clean-ups in the following patches.
> 
> Missing:
> 
> diff --git a/qga/commands-posix-ssh.c b/qga/commands-posix-ssh.c
> index b0e0b1d674f..cc1f5a708e4 100644
> --- a/qga/commands-posix-ssh.c
> +++ b/qga/commands-posix-ssh.c
> @@ -288,7 +288,6 @@ qmp_guest_ssh_get_authorized_keys(
>   }
> 
>   #ifdef QGA_BUILD_UNIT_TEST
> -#if GLIB_CHECK_VERSION(2, 60, 0)
>   static const strList test_key2 = {
>       .value = (char *)"algo key2 comments"
>   };
> @@ -484,11 +483,4 @@ int main(int argc, char *argv[])
> 
>       return g_test_run();
>   }
> -#else
> -int main(int argc, char *argv[])
> -{
> -    g_test_message("test skipped, needs glib >= 2.60");
> -    return 0;
> -}
> -#endif /* GLIB_2_60 */
>   #endif /* BUILD_UNIT_TEST */

Indeed! And there seems to be another GLIB_CHECK_VERSION(2,62,0) check in 
util/error-report.c which we likely can clean up now, too!

  Thomas



