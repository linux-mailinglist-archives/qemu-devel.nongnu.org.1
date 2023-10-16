Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F41F7CAF9C
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 18:36:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsQYq-00083C-Jf; Mon, 16 Oct 2023 12:35:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qsQYn-000832-2y
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 12:35:17 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qsQYl-0002Pd-IP
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 12:35:16 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-53b32dca0bfso9817721a12.0
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 09:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697474114; x=1698078914; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wxBLoxrbLPMB1pasH5cVOWw9S3wJBYncCBLnHidpH+s=;
 b=V8i0s8bzm2pGpzWQ3cYng0Bn4AEZ+jstI4nA5mUOOq754SlNOJtSjZL6xwhh0wNLJS
 9D7xvB5/EUZLpjyYmh3hyEeSRG+AUnteDYcW6V4URPh5xa7KVUDxaf+IHXWuuEOI3sYu
 n1se4fhAQBQ6hN3Wa+J9b+VPX0Sj5i95UZmT8x3391hGrh++kYEMjSUvKyjEDrgYPl91
 OC13HK3OkvKorFKwmST1zborrM5r4O/3bAXyBXGSPswXkxPXN1SbT7Z3ZNaNJ4n5gRV0
 83hiHhomhHYBJEttK2hCZ42guEFn276gJf955fw00vXMkhduxUYLuXltKr/7PBdwQle+
 OeQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697474114; x=1698078914;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wxBLoxrbLPMB1pasH5cVOWw9S3wJBYncCBLnHidpH+s=;
 b=MWbW/lZfhV4bq9kM4S5eYDyPpViA5J0eSZ+pUT4rw+tLyHrpv1nOMyIA0d/FVCTsh8
 oO0iHuOf3kNOJ4cYlNk5nOi4b265AYb9V/WDCBsJE1o/KfXukt5QHoxc1HFFKyAsHaz5
 wyCvA25NB8bLcFfPuokuM9+JNk786Z+3t/Fe3KGh5MrS/Dtk+smanxmD8sxOqbu+zgLL
 8+6L6P8qM55wTBwN3NH5SJNMD28aYO8JMaWNek8KjSwvNALLyY6g8jXESSG2h28/TwGF
 Tb8IQ7Iav3RIZ6iM40Fiaz5xFx3uns+vl53JibmApGTONFDcjaXipoLuO8qy7KT5ujfU
 VK5A==
X-Gm-Message-State: AOJu0Yy3yMABTRQ7X5weQzzm1OcmYZqXBu8B7I/WmzM6R9ngnEv4g57s
 cx4S8d/EEVvA98M6P049bU5fDRyor837PSE2YPZbRHOKRDLncUP8
X-Google-Smtp-Source: AGHT+IHm9f4CSTeK6t9SwUyQlbi//EeuB3DtLdbpB/3f3llg44tfBspex5rtrL52VaFR52j2A67gHd0GQFrO8ZXJhzg=
X-Received: by 2002:aa7:d597:0:b0:535:cbe5:a039 with SMTP id
 r23-20020aa7d597000000b00535cbe5a039mr7702594edq.12.1697474113811; Mon, 16
 Oct 2023 09:35:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230930235317.11469-1-viktor@daynix.com>
In-Reply-To: <20230930235317.11469-1-viktor@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Oct 2023 17:35:03 +0100
Message-ID: <CAFEAcA-A-kw2K_OLDri+VUnNz6NnWb25SAcYda5jchNhJ76x7g@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] elf2dmp: fixes of code analysis warnings
To: Viktor Prutyanov <viktor@daynix.com>
Cc: qemu-devel@nongnu.org, akihiko.odaki@daynix.com, yan@daynix.com, 
 viktor.prutyanov@phystech.edu
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Sun, 1 Oct 2023 at 00:53, Viktor Prutyanov <viktor@daynix.com> wrote:
>
> This series tries to fix Coverity warnings.
>
> v2: fix commit authorship, add CIDs

Applied to target-arm.next (since I took the last set of
elf2dmp patches), thanks.

-- PMM

