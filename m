Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9610B7D0FB8
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 14:34:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtogr-000233-9Y; Fri, 20 Oct 2023 08:33:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qtogl-00022k-M9
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 08:33:16 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qtogk-0003EN-6I
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 08:33:15 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40839807e82so4786815e9.0
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 05:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697805190; x=1698409990; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=B0pPZ/aWPmJi5nvDw5HJW2eqzTh5jKXIVj+NIdPV+WE=;
 b=wpUOJQFFKhKoTn3H+SWRqWC9rs6/tzG0w9MZnszurHd5mnohWq+h6k5NasyCU5lnkv
 x7stoTWWVCS729E74kTf6HdNJfMxFkDXSmX4U4v04xLd7D0CeOORaKimaDJRC2ylCs68
 AVP4wEdGMIviX7z/5UxyIgqswpGAGsEobHU3BdJHfAcsjO8Xscb+cN/ZxGvL7wy/PS+Z
 UUX2vvo8wAheocNPVgdJJgbzSpfr0q+obXYlck+t43Povj2vphTJ8+5dbIC0ZIo9KhZB
 86WLI3oO0gX1cClRevWyi1J8/tr14MHxrMyJjhcnMypwcDwpqZ5WrLGeW8DsUv+Juana
 rOxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697805190; x=1698409990;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=B0pPZ/aWPmJi5nvDw5HJW2eqzTh5jKXIVj+NIdPV+WE=;
 b=xL3wFTLm/f3gpK8cXVjSQIURJFOCbYBvhonkOvo34ZRl1qkwJk+ncH5brj/LR8C3Tj
 8oPFafwHU5moVWL01MVnaHTKmJAaVo2SlZPddD73OWSiaCZ3o9Fi44v5jomqvMN9h0Jx
 pM5+FyKHgbm742iXvc87/gDptgwm8sVi3xuBOVLt1MVCsFRA6msosxzgnpghdxsNJJ9v
 hfbcSBKmm5EAvQONSr1ilVoLtJ4xDQLkOrXoFGIBF65p7H4p5+9EB0RtYllNa8NYhZ/J
 +kjJ49+whsc7ZpRXtqaBtAOmWox9z8e/P5HGEVJGsasg3l8iRH8FlTkAx2TxwE/1JYai
 Fg7w==
X-Gm-Message-State: AOJu0Yw/IoIWJy8UJypwzO3oE9kW0L9SR3nHDkKNMYvkVN85bNZnxTqN
 LyY+6vcAE3R+0oUwAauySZJIKB0dcVooh6C/6FM=
X-Google-Smtp-Source: AGHT+IHBTkhiRC3WBOGt8/X+AhYpvP8ZZ/cMzsnFP/KQddBAWrVs+DL6Nc93u3jIfPdPxvcsDpR7ZA==
X-Received: by 2002:a05:600c:45cc:b0:402:ea8c:ea57 with SMTP id
 s12-20020a05600c45cc00b00402ea8cea57mr1542226wmo.7.1697805190352; 
 Fri, 20 Oct 2023 05:33:10 -0700 (PDT)
Received: from meli.delivery (adsl-165.37.6.1.tellas.gr. [37.6.1.165])
 by smtp.gmail.com with ESMTPSA id
 n15-20020a7bcbcf000000b004060f0a0fdbsm6838852wmi.41.2023.10.20.05.33.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 05:33:10 -0700 (PDT)
Date: Fri, 20 Oct 2023 15:31:00 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: 
Subject: Re: [PATCH 08/17] kvm: unify listeners for PIO address space
User-Agent: meli 0.8.2
References: <20231018163728.363879-1-pbonzini@redhat.com>
 <20231018163728.363879-9-pbonzini@redhat.com>
In-Reply-To: <20231018163728.363879-9-pbonzini@redhat.com>
Message-ID: <2tuv8.hmnbactgmy0a@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, 18 Oct 2023 19:37, Paolo Bonzini <pbonzini@redhat.com> wrote:
>Since we now assume that ioeventfds are present, kvm_io_listener is always
>registered.  Merge it with kvm_coalesced_pio_listener in a single
>listener.  Since PIO space does not have KVM memslots attached to it,
>the priority is irrelevant.
>
>Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>---
> accel/kvm/kvm-all.c | 11 ++---------
> 1 file changed, 2 insertions(+), 9 deletions(-)

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

