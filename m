Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0819C7EA1A9
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 18:05:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2aMy-0008Fl-Ml; Mon, 13 Nov 2023 12:05:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r2aMw-00089m-8k
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 12:05:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r2aMs-0004TS-JV
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 12:04:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699895097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wT1ZmGQi8gdWv1A4/ebK6SW/Inpjyt/TOr+VdqXgdzc=;
 b=Vmwr35kh34PxxSniXhI7ASY7yswt1m0QZWbr/8+k3FWJBIEzZB+4w/kQ1PNv9DHJZWf4Gh
 ng09m/VPYOATpU4b/blgTSF9yyZqH/tbvxanRzQ9L7t58pL31Ef7jgDBD1JtNmjik1u7FL
 Y/Cih3/k/WHDgjmWs3TemDuMo4KwHp4=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-PpouS6iuMzuS2qEvmc7S_Q-1; Mon, 13 Nov 2023 12:04:55 -0500
X-MC-Unique: PpouS6iuMzuS2qEvmc7S_Q-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-77a12fbe7eeso591315385a.2
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 09:04:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699895095; x=1700499895;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wT1ZmGQi8gdWv1A4/ebK6SW/Inpjyt/TOr+VdqXgdzc=;
 b=YBlAXX5oTw79spA3Fmq1YHmn9H2nC1R1cun3aVApUXBQmIEkYYRBXojowma05436Iy
 Aq/5ca9PVdhUuViu8zYbfO1OFJtII0/Ua4lXjQ39R5LO78LtGpCFXdDY/Pw2Z5zbq4Ad
 D9INsWckYo+UxfqjwsUMe0ws2evW+oVpqzESjgXv3EflpEWPcsqtgjB5Pnwyh6LaxMm5
 0ObG8JuShblLofBYrjZAlbQmWQx/+Fsa2iFvYCZM4aYZwvWE7vVp9dZF7WvgljPkkZcE
 z7p26kr8xyA8tkc/fAwbtsDaii9Uxq7XTZ5qdh2I5BMVpEJdZG+Xc6Pl+k9s266pMWre
 h1ow==
X-Gm-Message-State: AOJu0Yy5N3/MjshhGRonmx4iBCeYR2odOgktk/+NzFZm5FI3rsC3BJuy
 coegqA0yXJcPRndhSdhvkcpi2LgO/v0cnz8QtrFg8JmftCDn2j2i4fS3UC50QQFZGpAsM1HpSlh
 IThzETDfj8SurXaw=
X-Received: by 2002:a05:620a:911:b0:778:96ec:661 with SMTP id
 v17-20020a05620a091100b0077896ec0661mr7208473qkv.73.1699895095127; 
 Mon, 13 Nov 2023 09:04:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEXS39xUYrI3J+5AyqAvv5iBgg3Rm0sdklwf6Q/p0ecn7y0r2FzUjslfn8wubq64MdO8ol0Wg==
X-Received: by 2002:a05:620a:911:b0:778:96ec:661 with SMTP id
 v17-20020a05620a091100b0077896ec0661mr7208459qkv.73.1699895094908; 
 Mon, 13 Nov 2023 09:04:54 -0800 (PST)
Received: from [192.168.0.6] (ip-109-43-177-79.web.vodafone.de.
 [109.43.177.79]) by smtp.gmail.com with ESMTPSA id
 f3-20020a05620a12e300b0076e1e2d6496sm1993846qkl.104.2023.11.13.09.04.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Nov 2023 09:04:54 -0800 (PST)
Message-ID: <35f75a44-b76d-456a-b7b8-67bc3e0cad9c@redhat.com>
Date: Mon, 13 Nov 2023 18:04:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] risu: Add test summary
Content-Language: en-US
To: Sebastian Mitterle <smitterl@redhat.com>, peter.maydell@linaro.org
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20231108162356.36670-1-smitterl@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20231108162356.36670-1-smitterl@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 08/11/2023 17.23, Sebastian Mitterle wrote:
> Currently, a successful test run finishes silently with exit code 0.
> The last message on the console is "starting image" which can leave
> the user wondering if they executed the commands correctly.

Thanks for the patch, I think this is a good idea - it also initially 
puzzled me a couple of times due to the missing feedback.

> Now add a summary of the number of executed instructions in case
> of success. Don't add that message when printing the trace to
> stdout (`-t -`).
> 
> Tested:
> a) master/apprentice mode
> b) trace mode to file
> c) trace mode to stdout
> 
> Suggested-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Sebastian Mitterle <smitterl@redhat.com>
> ---
>   risu.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/risu.c b/risu.c
> index 36fc82a..740663a 100644
> --- a/risu.c
> +++ b/risu.c
> @@ -551,6 +551,7 @@ int main(int argc, char **argv)
>       struct option *longopts;
>       char *shortopts;
>       stack_t ss;
> +    int ret;
>   
>       longopts = setup_options(&shortopts);
>   
> @@ -635,8 +636,15 @@ int main(int argc, char **argv)
>       arch_init();
>   
>       if (ismaster) {
> -        return master();
> +        ret = master();
>       } else {
> -        return apprentice();
> +        ret = apprentice();
>       }
> +
> +    if (ret == EXIT_SUCCESS && (!trace || (trace  && strcmp(trace_fn, "-") != 0))) {

There's a superfluous white space here ------------^

Apart from that, I wonder whether the check for trace-to-stdout is really 
necessary, since you print the message to stderr below instead?

> +        fprintf(stderr, "No mismatches found. Executed %zd checkpoints.\n",
> +                signal_count);
> +    }
> +
> +    return ret;
>   }

  Thomas


