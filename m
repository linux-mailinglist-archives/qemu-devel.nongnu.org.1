Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CE977A7BD
	for <lists+qemu-devel@lfdr.de>; Sun, 13 Aug 2023 17:50:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVDKs-00088l-OD; Sun, 13 Aug 2023 11:48:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qVDKq-00088V-82
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 11:48:56 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qVDKo-0002Gu-K4
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 11:48:55 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-686f8614ce5so3408074b3a.3
 for <qemu-devel@nongnu.org>; Sun, 13 Aug 2023 08:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691941733; x=1692546533;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jHg5/l+AW6NLNmsfOrnITejIgoPyg91vp9nxeyUPQAQ=;
 b=ZhmXOF+/nJ6Sozv4AWogtURNzi4Epr/UR3JZCnms+xDUCvdeRLJDKb15L9TW40rf6v
 FUz7MwxwIcnmZo67h5GCdnwBJMTcHtR+QkqQ/SFWBx9i4DRmhSkJR715IuuvPw9MSQAT
 tmoi/xaGAv2Ka998C3P4EBbO7ZbFGuOj1IPkO7wOMeMD+pZQSn1+WH8pjsWq0WFk1SnE
 l+O69BxLN/9EV6aoLlMQ0VkpK55WmowPtib6kaVzeZGJwqSD7bl+yOFXjDLnoihXYvma
 mIq3uPuAXAuIO4CNijse2qST9iKysntVVh1y4nBcpX4vYDw2SNpIVfexlHhe+0dIEchD
 MF3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691941733; x=1692546533;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jHg5/l+AW6NLNmsfOrnITejIgoPyg91vp9nxeyUPQAQ=;
 b=EYvVWkJB7qPCmPoeeNKFS1DisHW83cdu9Hr5Jp6sybheo/+GJZ4t8orpOaFtd+zV2f
 2h2cvwoWoFw5UgsbXpalabxvmZtgvroi3vy/spaM/bE2jejru2NCeqjCaMqgwKba50X1
 1v1PsCEyyEFGUZxrPyHaEtORp6y4kFbfuEnhldPKEMomd14aWtN7t1ZBSKwzcWRu5LVP
 J1z24aROMEJlIVVW/q+/1lwcYcPBq8BWy11Zp3fXhYhyMITDfxSBeGCoiabbQh6s21wF
 Ds6fMeuocPCEvIM29yjkuEXOv6nfqZ7j/7WrzwRIalsgqN/2sfjjFErp7TPirjYBULIz
 xa7Q==
X-Gm-Message-State: AOJu0YwrnAVL+gtM2XAPmSPCEs8SSMhd7il8DhIm/cqP6QatzAakPSST
 nXsmANcCKnEiqYBGZ/q3HJz6R3uTkwNh8ZLLtKI=
X-Google-Smtp-Source: AGHT+IG6Ra0FAS838YtgXgmKcqH0Yv1KaTkzfrFv0Dhfkc1pfLUbX7kxGjb44vHiBeBbhVGfx7OPtw==
X-Received: by 2002:a05:6a20:3204:b0:13b:cc09:a547 with SMTP id
 hl4-20020a056a20320400b0013bcc09a547mr8654041pzc.36.1691941732946; 
 Sun, 13 Aug 2023 08:48:52 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:8022:692c:81e3:39db?
 ([2602:47:d483:7301:8022:692c:81e3:39db])
 by smtp.gmail.com with ESMTPSA id
 ff10-20020a056a002f4a00b00682a8e600f0sm6414620pfb.35.2023.08.13.08.48.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Aug 2023 08:48:52 -0700 (PDT)
Message-ID: <ebf2bcdf-be70-88a0-7dba-656c55757c78@linaro.org>
Date: Sun, 13 Aug 2023 08:48:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 27/32] Implement do_freebsd_realpathat syscall
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, =?UTF-8?Q?Mika=c3=abl_Urankar?= <mikael.urankar@gmail.com>
References: <20230813031013.1743-1-kariem.taha2.7@gmail.com>
 <20230813031013.1743-28-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230813031013.1743-28-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -64
X-Spam_score: -6.5
X-Spam_bar: ------
X-Spam_report: (-6.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.359,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 8/12/23 20:10, Karim Taha wrote:
> +#if defined(__FreeBSD_version) && __FreeBSD_version >= 1300080
> +extern int __realpathat(int fd, const char *path, char *buf, size_t size,
> +        int flags);
> +//https://svnweb.freebsd.org/base?view=revision&revision=358172
> +// no man page

C comments, not C++.


r~

