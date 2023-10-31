Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C13077DD13D
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 17:10:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxrJR-0005N1-8J; Tue, 31 Oct 2023 12:09:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freddy77@gmail.com>)
 id 1qxrJO-0005MM-Rr
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 12:09:50 -0400
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <freddy77@gmail.com>)
 id 1qxrJH-0000XV-IH
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 12:09:50 -0400
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-58706a0309dso1131652eaf.1
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 09:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698768582; x=1699373382; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7jncBLDPh2/ALEBgBPPg0YZBFBgs1TcfbH/aYL/GONI=;
 b=JdlESqSVCpuqJXAP8E1+FBLMDjJEbtrylNotePXRNHLHNVvXeAyDjIcAIJs71ciWhr
 lmlAylNWYBAfUsEp5rphsjTxu2R9yVAjbRyj7ddjwRs2v3ZCe9pt200mW+HKOngnpHj4
 fwYKzHCPu1/MVd3SAeb36yLRbzGoVqsGLaNCJKSYBwXKa2mKOU8gGOLFbfyKq0Z2kjzg
 NX8kEmm8ycDctVb6cUWV5UQ52OER/jgrwRw10C8ouoiYdL8PYFnecVcQZ5mGVGQi/dNh
 vMm7WpjXR1mpME2OapSWT2ZFHf1/Kuikp0/eC7UnWQSjSl8dDy5XVr8hL2iWEkZdYG+r
 ielQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698768582; x=1699373382;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7jncBLDPh2/ALEBgBPPg0YZBFBgs1TcfbH/aYL/GONI=;
 b=fP9b+QIuzNoaVqKxmr63LHzGNFJdGt0wBVg+4pi5I/uIKCugSS/MTTBmfibo1xuJoY
 afpiS3WL+ojd6T/a5QqOI+L1/jUqVwBq1RxJyR7cCmri5XE1hifARx9sk10l6/PjU3N0
 a6FgOhH1+tE8/obLCAr6ExyCHcpkjuPUOE/OElBqdq1wEubbZcKEPxzuV1u7zDCw0sBZ
 xkd0u664VYkLQjJg82X5xB6MjeNpFtwX4GJ2pN/lwExtpSOGlndqIkmtW3zailH+NxGu
 S/ojeTuZOqF3+z8kS5nYHlQACWDUzrF2zDQKJfQ0qG6ZScfaUtsKgikBQQd/TnuyIgXc
 9z8g==
X-Gm-Message-State: AOJu0YxXJp0RWx5aQ7ZKGzafjWSQLBE+psq9sRXN8ZWkFK7eHqbABcxG
 fk+c2MbqtIj+j0bBHfIwIapdNqHBH7Rsdxu1d2OtvkmIbuQ=
X-Google-Smtp-Source: AGHT+IFku84gbkYcdA2/RbM3ZIfxq9roh3FHKK0wyo8VBm/XblL2eyHTp5Ng6i9s8YuvgAh3vC948EcqWvgR2ayccMk=
X-Received: by 2002:a4a:a50c:0:b0:57b:7e41:9f11 with SMTP id
 v12-20020a4aa50c000000b0057b7e419f11mr11307407ook.2.1698768582019; Tue, 31
 Oct 2023 09:09:42 -0700 (PDT)
MIME-Version: 1.0
References: <trinity-7fdc326d-33f4-44e9-8f13-86c244f865e4-1698604269939@3c-app-mailcom-lxa03>
In-Reply-To: <trinity-7fdc326d-33f4-44e9-8f13-86c244f865e4-1698604269939@3c-app-mailcom-lxa03>
From: Frediano Ziglio <freddy77@gmail.com>
Date: Tue, 31 Oct 2023 16:09:30 +0000
Message-ID: <CAHt6W4dAQzjWaGKjRDRezjZDFh=p-Tu6dtu466J8wBdiFtxvdg@mail.gmail.com>
Subject: Re: qemu-system-i386
To: Joachim Roden <jr-edv@mail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=freddy77@gmail.com; helo=mail-oo1-xc2e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi,
  did you compile on yourself? Downloaded from some website?

Regards,
   Frediano

Il giorno dom 29 ott 2023 alle ore 20:13 Joachim Roden
<jr-edv@mail.com> ha scritto:

