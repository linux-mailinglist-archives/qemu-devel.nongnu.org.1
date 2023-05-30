Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C5A715C71
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 13:00:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3x4l-0006OI-UV; Tue, 30 May 2023 06:59:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1q3x4k-0006O4-8V; Tue, 30 May 2023 06:59:38 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1q3x4i-00058b-ST; Tue, 30 May 2023 06:59:38 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-565a022ef06so60390627b3.3; 
 Tue, 30 May 2023 03:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685444375; x=1688036375;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=M7qTBNLRqlHHE/7JqlyFxyD6MlDoPS1461StNt1tAuc=;
 b=SwZ0LFLtq50xlHlvIsEmQxkUfJpV0eQTlJW9MNmC0NBiclUvydhH+Pz7EEOiVhlLZK
 GdlpZZUsPnitC6npfvjEM5z+rLkELE931IHq26TbIFrT/gJKMiDInxS3S6aMVmCeCoZS
 kdeUVOkQ+NwM2gdkxEOBBNvZtTmDoVKMZFy0roKrQ/B9xqkImvFHnN1udIzNJmWZsEns
 +/AlmrXgMKcovBA58R+JRE1DwQ8KwU0Uy/DqoBRbsfw/Lgc6D/2YKMIQeLSWuBaB6NPx
 rwbjK1IqzgApgdf9yU24k4pjm7KG5XoU4e/UKjGkFjoT1T1VCazuRmNV82AZE8WrXPjj
 3Dcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685444375; x=1688036375;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M7qTBNLRqlHHE/7JqlyFxyD6MlDoPS1461StNt1tAuc=;
 b=VYOyFLKI0H/P3+SvoHZYbqOU79go2epENS6cx+gtA1vuDtRWmhn/m6d9tU65aV849z
 fxwpcKK9zg2LxnyeLyQHM7lrQJ2kH7aS9jQ/zu9S0ILN5TjdbuO0g1wsqitFg1US+oph
 BJ4X/OvKXrufkb90M8sjM0S/UcjtB+6wYXkEehjHaFEKPmlGWwhd7q9lSqs+H50oTxF0
 EcMh7GTFFmA4LKNwTYFV/Ik3MhS/y6QlsqXq1VS/FI9xge07NjSPjdU9Yo8ciDoMbDXp
 ViszNnT6dK/zH05mqhz8cQlERXZ/szfNCQ3cSCYZ/3NOuz5Po1bVbSDdbdY156Gcm7Y/
 gd5w==
X-Gm-Message-State: AC+VfDyCG4wTDxM0/p3zBkvNU795yWMxMSiYTG3U5I0PVJJim2MQ7AUu
 AFNvVWkukwMnEtxryAjjTnJ6rEfW5HMdwdlz6e4=
X-Google-Smtp-Source: ACHHUZ4/HykvXW6ahu8vSe83ZvAmV/Dgq4uiC1G/SwDVLAhdMiSR1i+IxkpAtx+RdEm8xxCeOyTp+irBWwvOqoglgGc=
X-Received: by 2002:a0d:ed04:0:b0:560:befc:6682 with SMTP id
 w4-20020a0ded04000000b00560befc6682mr1909729ywe.42.1685444374872; Tue, 30 May
 2023 03:59:34 -0700 (PDT)
MIME-Version: 1.0
References: <f4d89121-1b31-ae77-0ea9-67df940d2f15@tls.msk.ru>
 <ZHXCA+bejh+7z3Gu@redhat.com>
 <59c1d675-48c7-083f-7357-7b34f0523405@tls.msk.ru>
In-Reply-To: <59c1d675-48c7-083f-7357-7b34f0523405@tls.msk.ru>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 30 May 2023 06:59:22 -0400
Message-ID: <CAJSP0QWNsWFhLsQN8XakY0wjH2OOVfxyJMeEfyr794_de8pPxw@mail.gmail.com>
Subject: Re: stable-8.0: block/export: call blk_set_dev_ops and Fix null
 pointer dereference in error path
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, 
 qemu-stable <qemu-stable@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=stefanha@gmail.com; helo=mail-yw1-x112d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue, 30 May 2023 at 06:33, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> 30.05.2023 12:29, Kevin Wolf wrote:...
> > Both look like valid options.
> >
> > But if you want a concrete recommendation from me... I would assume that
> > you picked it up for a reason even if you don't remember it now (maybe
> > it was a dependency of something else?). It also claims to be fixing two
> > other commits. So I think my tendency would be to pick the second one
> > additionally.
>
> Yeah, I decided to pick both. Thank you for the comment and the confirmation!

Sorry for the trouble. I caught up on both your email threads and
agree with the solutions you chose (adding Kevin's fix and tagging
v8.0.2).

Stefan

