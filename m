Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B75F82F272
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 17:35:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPmOB-0004SC-5p; Tue, 16 Jan 2024 11:34:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPmO8-0004Ri-W5
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 11:34:09 -0500
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPmO7-0004Fc-7C
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 11:34:08 -0500
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-50e7c6f0487so11627260e87.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 08:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705422845; x=1706027645; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=r6Ai0z3wdHjUVQrr8kOh9qrkmDCfEK898oSdJUNYiMw=;
 b=anFcE0aD3wXObKc3r0dGa1oELpRj6g9KPlpFcyWN39CIFqUFoZtvAPzXtI2KwI89IN
 3X2RDb+v8AdXtDhmq6zO9v9L7hZDZs6685qp5ku5TZ3AxtgqkDUEaz6jy5d8PeN+QxHa
 00hi8Zeytsq6wpZZMBl5L1kDfItGESrKu8ZqeVl6ESr0UNbH8LvZwZb0x/H3EKcDIbc6
 mgdIpMWgDtmb0wxnpqosP7CkZfkiYXQQbJNynikoYlgTlsoejuR0KQPrvLNXnxxH6i+v
 J1cYlzmBgWCSOeW8fTkKUgdbVigwbtdZbF4ne5M5Vk7frZIi3wwoU/yqYVaYD9RvNT/S
 zdbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705422845; x=1706027645;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r6Ai0z3wdHjUVQrr8kOh9qrkmDCfEK898oSdJUNYiMw=;
 b=wYghT+5qKQfXfOrIKV0v1bXn/dtXlcUr75/v/RZ8vpg/lcZWRhl6iATvamtQKUsZDq
 +DnxI7pJGO0VOgS3ue+7poPdQHajSsAD6yFEWAjNiwJ4XYY1QA3+jSqxYK2VbmGVu+Bc
 VPm3yHqTLkRdDzX7T1F8n5v1kDvUWBhgxJJganroRpfq3hi+1DTKGmcR1elTqADQetdy
 ZIppusWHUHdcHreF4SCAJaczWIxuZ6vjk4yt1RjcWWnmVSv7X/K38gHl4OsIclgefBT3
 G4GcplYYyvunLOZ6ldE8m47TzN/1HUmcYJaxseoCi6PNrkdtGMz2yZLGmuGS+6gEeWVs
 sztA==
X-Gm-Message-State: AOJu0YzFbT/YXDGlwBXghDFulBTHj6psReSdI9uG/xVTv04eYlRMYYhh
 XZuTGcKqv7qDN4d3qj+umW3dGpncAX8o0chXCvPDlUzgLd/2Bw==
X-Google-Smtp-Source: AGHT+IHRqEuoCOJm3zEmHM8mOBTikIee+nOdN9aZkpeLy8HSmpNHtjh3cMVzEYxh3ybUaJdDtl6llUQIVZiXsLHo33s=
X-Received: by 2002:a19:4f4b:0:b0:50e:5448:3313 with SMTP id
 a11-20020a194f4b000000b0050e54483313mr2193255lfk.9.1705422845449; Tue, 16 Jan
 2024 08:34:05 -0800 (PST)
MIME-Version: 1.0
References: <20240116031947.69017-1-peterx@redhat.com>
In-Reply-To: <20240116031947.69017-1-peterx@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jan 2024 16:33:54 +0000
Message-ID: <CAFEAcA8Mf1uyW7k8akYc-wkVFgQAFyJK0sFeStJ=L9pP415NqQ@mail.gmail.com>
Subject: Re: [PULL 00/20] Migration 20240116 patches
To: peterx@redhat.com
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, 16 Jan 2024 at 03:19, <peterx@redhat.com> wrote:
>
> From: Peter Xu <peterx@redhat.com>
>
> The following changes since commit 977542ded7e6b28d2bc077bcda24568c716e393c:
>
>   Merge tag 'pull-testing-updates-120124-2' of https://gitlab.com/stsquad/qemu into staging (2024-01-12 14:02:53 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/peterx/qemu.git tags/migration-20240116-pull-request
>
> for you to fetch changes up to 44ce1b5d2fc77343f6a318cb3de613336a240048:
>
>   migration/rdma: define htonll/ntohll only if not predefined (2024-01-16 11:16:10 +0800)
>
> ----------------------------------------------------------------
> Migration pull request 2nd batch for 9.0
>
> - Het's cleanup on migration qmp command paths
> - Fabiano's migration cleanups and test improvements
> - Fabiano's patch to re-enable multifd-cancel test
> - Peter's migration doc reorganizations
> - Nick Briggs's fix for Solaries build on rdma
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

