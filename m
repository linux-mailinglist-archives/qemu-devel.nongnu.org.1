Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 763977E199A
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 06:17:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzryh-0007zN-PW; Mon, 06 Nov 2023 00:16:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roman@roolebo.dev>) id 1qzryd-0007yq-4g
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 00:16:43 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roman@roolebo.dev>) id 1qzryX-0001pJ-VP
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 00:16:42 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1cc5916d578so37171365ad.2
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 21:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=roolebo.dev; s=mail; t=1699247796; x=1699852596; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hqCr2nUxUILU6qkD5MOh90wz/wvt0TWvhqtZ64xeldM=;
 b=EwfhEjFDEDE+VuUy2AiuK28YZiP15u16K0gk9sK3iiCxsPNVSuyqhzJIORGAM9sil3
 /HmbJkw5+za1msxuuL8XOIk/MBw2O/7pg9QiFyXODwZj+0LlHq5nTdJJ1Gr86GLVnIjV
 4g6F9EeyjrUBK9uUMdALkfzueJjMJ6JpRq4KXXL6w0ctpuYb90/wfLKMRsbygiFaDOQg
 V8k1uXMFtWJLWQzE+4ecS/qp9SttW65ad91szb8PgTDAgJVzbi+/HuN2oAJy/UWF4USb
 LUgH/qLB3bd3T3DQldms4soJ1/NngGELSsVRXffskjQL0MtUVySG5mR3o/QVK0Q2SwVC
 GmCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699247796; x=1699852596;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hqCr2nUxUILU6qkD5MOh90wz/wvt0TWvhqtZ64xeldM=;
 b=woEQ+KXpA+QMzxIKr9p1AT8JjPkE4HDCU40tvrWOa8bE1/iEnZzrLIw7rAKtML5joN
 Qx/wkOCc5/rmXvULnkwN/mKatXmEBbWgWtkgGHhG6drXHAzhdX+7HsRUGUBd5GaoHJEl
 mWV23OcSOQoVDdb5hsG1vEqKS1hy4m6s7OGX7NKl/R01HeYoYK9HFk9uiZ6P9CMuHEPk
 GkTBlsU8OWWWgrP8idIn/BljiQEPjt1Ia8V0XxiTDx6Df6HmqzKFXBEaPB6HZsH8VevS
 L/nxt6Z25VvkmYRvjP78j7fvzFR+u/rj6Ezld20ROqoJcQh7AWeaczMHPvNetOugdPg5
 KgHQ==
X-Gm-Message-State: AOJu0Yxjx5Se6WZAeoEqYlC5IZPHlcWlqNi4gxJ76/QvG3U0oDHahhZf
 YmAPH3RtFVEZjkWRv0pEopNqRQ==
X-Google-Smtp-Source: AGHT+IENGPOT3BodV3BrIESxQeN0vr9X7Hf1ngF7xxz6vLakAIddQVSHHmtUiKyKli4TzBkVjv5iMw==
X-Received: by 2002:a17:902:f689:b0:1cc:6597:f421 with SMTP id
 l9-20020a170902f68900b001cc6597f421mr22476692plg.48.1699247796363; 
 Sun, 05 Nov 2023 21:16:36 -0800 (PST)
Received: from localhost ([123.231.99.131]) by smtp.gmail.com with ESMTPSA id
 jj5-20020a170903048500b001b896d0eb3dsm4963571plb.8.2023.11.05.21.16.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 21:16:35 -0800 (PST)
Date: Mon, 6 Nov 2023 10:46:32 +0530
From: Roman Bolshakov <roman@roolebo.dev>
To: Phil Dennis-Jordan <phil@philjordan.eu>
Cc: qemu-devel@nongnu.org, dirty@apple.com, pbonzini@redhat.com,
 lists@philjordan.eu
Subject: Re: [PATCH v2 2/4] hvf: Fixes some compilation warnings
Message-ID: <ZUh2sJrAikUJqFn1@roolebo.dev>
References: <20231021200518.30125-1-phil@philjordan.eu>
 <20231021200518.30125-3-phil@philjordan.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231021200518.30125-3-phil@philjordan.eu>
Received-SPF: none client-ip=2607:f8b0:4864:20::62a;
 envelope-from=roman@roolebo.dev; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

On Sat, Oct 21, 2023 at 10:05:16PM +0200, Phil Dennis-Jordan wrote:
> A bunch of function definitions used empty parentheses instead of (void) syntax, yielding the following warning when building with clang on macOS:
> 
> warning: a function declaration without a prototype is deprecated in all versions of C [-Wstrict-prototypes]
> 
> In addition to fixing these function headers, it also fixes what appears to be a typo causing a variable to be unused after initialisation.
> 
> warning: variable 'entry_ctls' set but not used [-Wunused-but-set-variable]
> 

Reviewed-by: Roman Bolshakov <roman@roolebo.dev>
Tested-by: Roman Bolshakov <roman@roolebo.dev>

Thanks,
Roman

