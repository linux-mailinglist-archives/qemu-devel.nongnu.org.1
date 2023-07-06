Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B83274A263
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 18:43:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHS4D-0007i1-V1; Thu, 06 Jul 2023 12:42:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qHS4B-0007gj-VT
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 12:42:51 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qHS4A-0004BR-94
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 12:42:51 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2b5c231c23aso14417021fa.0
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 09:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688661768; x=1691253768;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mCgMcmRBiPxG28jfyIvn98PIf7zhjIQFTtaUi8xKxC0=;
 b=SdxpZasiKmpSDgjjXEaucPIx8UKEK1FCX/9NIhIkRH/H3hlj5QgW3UOvImPXcRRk64
 OOBvaE/i4gMFyfGKYCHiFdbnSDeSRxIakEsMAmM+AQpKJx+JPN9IwvkUSEQa1ybDGTjW
 U/dRkZkKSVTNLxGvdyymNrnAS8PZ6RoSbhTjuwgOVgzhN1AEHPcWVacf0SO2rftzWQPA
 CKgcdkS//Ksw4MsCTMAqRDrrciIGjpkxwsYj345Ws4jE80qmhCC0z5cvHiJIrUruXCKh
 KCeJW7J59JRaTz0iKP3nCfJl34yGNU+Xpdiq3xUZECS/I6iTIjxfpbhWRsZx7gi/BeVf
 SD9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688661768; x=1691253768;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mCgMcmRBiPxG28jfyIvn98PIf7zhjIQFTtaUi8xKxC0=;
 b=ZZhDJ0m74nx+zxGLf/nThVUGo8thU771wAGJ24w1m2xOWGaMXPJV/T/GNweuFGHz5A
 7UubTKEwdlFdR8KDchCht0hgDNjOWPK+4uTObm0GcPqsIfUi0ZOkBXlNwcp7CSOWV4O6
 ovwn/92CoELLwmMqyQ5PvaFcOVJpiMepTMLM5//+m2XIyG9AZ9OQcNkAzyT5pjLqReKe
 alzc5LcIKOcHHABAnFYxHZ4bKYCo76hi6fKdwEPi1dd63e1lz3IlNg1ri0kDy6Xsws0C
 +ZQaDqjoUnjDcTl7RofQWRDMmB7XvUfqkbL3Fh2lhQqpY6VfaZFB3177xWZ2dnlNs59W
 VJzA==
X-Gm-Message-State: ABy/qLYTZrYIScEBb0DzAHAcRxi9W6aCM+HcDm7ENFCldxVYNHKsAGmX
 +ucPE4N2pVLs3JUgAS5ma1lXvw==
X-Google-Smtp-Source: APBJJlF6woPh8CiOT4XT4dSY7lj6SmpGxGfxjsMC4bR67y5qanQA9YFge13LGxVOJCtqK0YArjmkCA==
X-Received: by 2002:a2e:8809:0:b0:2b6:fc84:4949 with SMTP id
 x9-20020a2e8809000000b002b6fc844949mr1623402ljh.50.1688661768045; 
 Thu, 06 Jul 2023 09:42:48 -0700 (PDT)
Received: from [192.168.1.102] ([176.187.199.225])
 by smtp.gmail.com with ESMTPSA id
 qq2-20020a17090720c200b0098860721959sm1027127ejb.198.2023.07.06.09.42.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jul 2023 09:42:47 -0700 (PDT)
Message-ID: <3ed74089-bfca-b779-3f21-a8e2f82d8741@linaro.org>
Date: Thu, 6 Jul 2023 18:42:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 1/2] migration: factor out "resume_requested" in
 qmp_migrate()
Content-Language: en-US
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Peter Xu <peterx@redhat.com>, qemu-trivial@nongnu.org
References: <20230706102937.82490-1-lersek@redhat.com>
 <20230706102937.82490-2-lersek@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230706102937.82490-2-lersek@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22f.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 6/7/23 12:29, Laszlo Ersek wrote:
> It cuts back on those awkward, duplicated !(has_resume && resume)
> expressions.
> 
> Cc: Juan Quintela <quintela@redhat.com> (maintainer:Migration)
> Cc: Leonardo Bras <leobras@redhat.com> (reviewer:Migration)
> Cc: Peter Xu <peterx@redhat.com> (reviewer:Migration)
> Cc: qemu-trivial@nongnu.org
> Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=2018404
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> ---
>   migration/migration.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


