Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 71658708E6E
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 05:44:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzr16-0007O7-CE; Thu, 18 May 2023 23:42:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pzr14-0007MR-7g
 for qemu-devel@nongnu.org; Thu, 18 May 2023 23:42:54 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pzr12-00029v-6d
 for qemu-devel@nongnu.org; Thu, 18 May 2023 23:42:53 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1ae6dce19f7so9371165ad.3
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 20:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684467770; x=1687059770;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bccI2dXTxxrVflqs9UTD0H1CtmEDmXsIjEEtfiwtt3w=;
 b=G4lf7552oh5dkdo5reg2QGmQh0aVykI/K/DC0HfMVDNuBhHFsea+WeJl3nhos6NUfV
 m67z4n/DUcsG39VWK8fMjSl4I44LZ7/8csVODmlcRHTK3s2XsGp9HbBhBFqIqxAFrJz5
 GUmoeUgoInakyns4o/oLjt6pL742vdouwN3UL3XtRmE0Q3pO8k6iOZB6mtVNjua+88Kn
 Jqg9LYqj+voTHOBfbfLlIekfZO7+uWDf+cIiyKlpukPVKO8yDPDoBgAugHa4S004lAp2
 OF8zZkF3ioNbTVKBvO0SSqroycjkBa5Dsi8z6H7sGURwP0SYBEOcNSjBioW4fwEQDcHM
 1+iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684467770; x=1687059770;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bccI2dXTxxrVflqs9UTD0H1CtmEDmXsIjEEtfiwtt3w=;
 b=KK9iJDipmnwCRV8uCooVSEpvLD7rh4sxcpXGjkR/ZrgxdttFJuFFauAst7TmQGXZ5W
 f9k6IE6E8ilS6T74SiPo8hZjknYnPmIO2XrlXq4i8pZ0DeHNnJFaEEV6GagtfAlt7KB9
 yMNnHDmjhhokU5xm/zlpgrBzm6WUhg+vt+ouK25KQ3Q0Bp8qsZS+TRvBTHukGxmeomRf
 CRFVXuSqpIOle6g6HD4bfjO1RPrcQiFuFJ6ENmZDWWTsXihO97OkhMBo+skwBHtgIZmF
 18G2Tyh4eOAOQoPpjYzlgZthyu4zqF2HG6GAXsdgm6toL8peCcZ+wKMzrOtrxi7RF06K
 LBMA==
X-Gm-Message-State: AC+VfDzopNL7V8TibY0qke9yXDBaL3J99i4VdkclV/8UFaOTgnGSW9Xp
 dPbMiAEFhyOB1LY5HqsRuBvmQA==
X-Google-Smtp-Source: ACHHUZ7CDbnRP8nDhlK/lFqmwowVqVU3+Pfb4EMT0A7SMSDEZy06NY2oPNkMUuFxWW3SM9UsDuqYfQ==
X-Received: by 2002:a17:902:b48f:b0:1a8:1c9a:f68 with SMTP id
 y15-20020a170902b48f00b001a81c9a0f68mr1319774plr.36.1684467769948; 
 Thu, 18 May 2023 20:42:49 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:5dd2:c230:399b:cdc1?
 ([2602:ae:1598:4c01:5dd2:c230:399b:cdc1])
 by smtp.gmail.com with ESMTPSA id
 h6-20020a170902eec600b001ae268978cfsm204424plb.259.2023.05.18.20.42.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 May 2023 20:42:49 -0700 (PDT)
Message-ID: <677a2198-4817-efac-fa80-4ae4a169bbc8@linaro.org>
Date: Thu, 18 May 2023 20:42:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 00/12] Migration 20230518 patches
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
References: <20230518171304.95006-1-quintela@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230518171304.95006-1-quintela@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.544,
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

On 5/18/23 10:12, Juan Quintela wrote:
> The following changes since commit 266ccbb27b3ec6661f22395ec2c41d854c94d761:
> 
>    Merge tag 'pull-target-arm-20230518' ofhttps://git.linaro.org/people/pmaydell/qemu-arm  into staging (2023-05-18 06:08:30 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/juan.quintela/qemu.git  tags/migration-20230518-pull-request
> 
> for you to fetch changes up to ba9d2cbc01b4e33f9a97edcd77247831a333eac2:
> 
>    migration: Fix duplicated included in meson.build (2023-05-18 18:41:53 +0200)
> 
> ----------------------------------------------------------------
> Migration Pull request
> 
> Hi
> 
> Based on latest reviewed parts of migration:
> - Disable colo (vladimir)
> - Migration atomic counters (juan)
> 
> Please apply.

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


