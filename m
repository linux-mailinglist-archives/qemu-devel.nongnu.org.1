Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A04703E9C
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 22:28:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyemu-0006lY-4w; Mon, 15 May 2023 16:27:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pyemi-0006jV-Bq
 for qemu-devel@nongnu.org; Mon, 15 May 2023 16:27:08 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pyemb-0003am-MV
 for qemu-devel@nongnu.org; Mon, 15 May 2023 16:27:07 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-643bb9cdd6eso11084582b3a.1
 for <qemu-devel@nongnu.org>; Mon, 15 May 2023 13:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684182417; x=1686774417;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9BxxDglkvKxoFaxWpf9peiskGXqb02xMllqxzP1GKhg=;
 b=CfsYOmqI3OjvnDKbBnyUrCQDlCI082Pkf4b/4VHTOBMiqboJooEyxNTcFbmJQt5zTt
 izWpNm/iNLgJhCFQiifMdWWEymlaVYSbCs6mK1DLn9GT855PGNX42Z12fC6iJlCwHld8
 kLt6BLxok2+nBDvNp/lI4HIcYTV283EcYV8lOsnBjV8jF83Q+ubd8VdwSDH/N9sk8xPi
 VMcikCqd4hpadPbtJtVxzWb0PUMLvvaIZzIsaQ7cNS4E/M2/157c/0VanLvhP5peeWNL
 B5qZ4W7Z6FgL2YRgIaJzNAoxzzPUUkNDgaRrOowy9z4NCh/uxhSxW39SORZ34t/7Yhax
 tT8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684182417; x=1686774417;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9BxxDglkvKxoFaxWpf9peiskGXqb02xMllqxzP1GKhg=;
 b=SZx+8raV/RE0Cnq7GVFp9V1ceUtfqwiizhes5DCFevwcc5A+uRfoly4wx3ZVX7u7j4
 xrEoOBTYj+roIgHULcrWqTiWLk5DnAlFJ2HSjADP/hUa+ZhWKVaDBt5ZzXejUd4huUZ8
 e81RTvcVTeNgWhMDu2oegrpOJiHIJPvmcO+UpEgh8UaOg/q/kdii+xq5s/KPMnsyMbkr
 oNL/zx3wrVfIUcQo7KG42l+8c5cNAw5XuRhDHl+ohofMjoYVwWMU/p+SAYGiL0RLa3DY
 i8D415+3vB5b0dw63tA+K6uQH7TLE8R8gSNdjeTMonmcgEaOD2zxGuAFanC8t55y3dE6
 4pLA==
X-Gm-Message-State: AC+VfDyZFUALALQoGZyJ1kEEPjVSX4QvT6zAfTiQDEBv40x3S4AdD4Dm
 sbJEIhufX8tmA+vFerfxMqY1ZQ==
X-Google-Smtp-Source: ACHHUZ4WF0BWudi2cGW5p9UTK4J61e6+i4D/G7bZLlxFhhMqfrb185lGK5JObiMnVaD0GNfHnC5xtg==
X-Received: by 2002:a05:6a00:15c6:b0:647:7ee8:6251 with SMTP id
 o6-20020a056a0015c600b006477ee86251mr30881281pfu.21.1684182417196; 
 Mon, 15 May 2023 13:26:57 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:9902:96ac:8d8c:4366?
 ([2602:ae:1598:4c01:9902:96ac:8d8c:4366])
 by smtp.gmail.com with ESMTPSA id
 f17-20020aa78b11000000b00642ea56f06fsm12214103pfd.0.2023.05.15.13.26.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 May 2023 13:26:56 -0700 (PDT)
Message-ID: <1387fb34-d366-b517-ef30-057d4621d495@linaro.org>
Date: Mon, 15 May 2023 13:26:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PULL 00/11] Migration 20230515 patches
Content-Language: en-US
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Leonardo Bras <leobras@redhat.com>, Peter Xu <peterx@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>
References: <20230515123334.58995-1-quintela@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230515123334.58995-1-quintela@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.811,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 5/15/23 05:33, Juan Quintela wrote:
> The following changes since commit 8844bb8d896595ee1d25d21c770e6e6f29803097:
> 
>    Merge tag 'or1k-pull-request-20230513' ofhttps://github.com/stffrdhrn/qemu  into staging (2023-05-13 11:23:14 +0100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/juan.quintela/qemu.git  tags/migration-20230515-pull-request
> 
> for you to fetch changes up to 6da835d42a2163b43578ae745bc613b06dd5d23c:
> 
>    qemu-file: Remove total from qemu_file_total_transferred_*() (2023-05-15 13:46:14 +0200)
> 
> ----------------------------------------------------------------
> Migration Pull request 20230515
> 
> Hi
> 
> On this PULL:
> - use xxHash for calculate dirty_rate (andrei)
> - Create qemu_target_pages_to_MiB() and use them (quintela)
> - make dirtyrate target independent (quintela)
> - Merge 5 patches from atomic counters series (quintela)
> 
> Please apply.

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


