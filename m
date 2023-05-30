Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A862A715EA6
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 14:14:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3yEO-0003Mq-QP; Tue, 30 May 2023 08:13:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q3yEG-00037R-Vj
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:13:36 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q3yEB-0005eZ-Ma
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:13:31 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5148f299105so6498160a12.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 05:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685448803; x=1688040803;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=djw57wLm2AKVTtEQDzpFrlQDCAohn7opPMijaqpiwnU=;
 b=khrBFellb3EG5PIT9sa/Ms/YpCInzCeVqy261qcEWLwwGhmmDBkGT6IMq7z5oDRY4b
 ykaNmhE8v6Klk5KjjW7pNDRE2qOPFcmk5UKdH60Ef4I1yWiCKJ1qIcUVQElP+ZQF3q8g
 5F2PSYBEiwNrJ3s/QMEG/TWG/OKDteTGiV+HUOUfk601DUkZ6umgvdn/GLkgOqfNZ5z7
 f/Kj7YduVMiI78ajBmgcWejcMMWS3+97WmZOe2E+52DLyuElOyCRc5wjZVNBHiTIgfb+
 HHGSHmrC4jik4eSquultQSEzkrC1yL1diqanetvCM0l0WQrIVNpcTZiB/5X0ZbNXDU2V
 NWwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685448803; x=1688040803;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=djw57wLm2AKVTtEQDzpFrlQDCAohn7opPMijaqpiwnU=;
 b=EJiD9qDySQ8B/QvDSr0dTMwUHGsb4nE+RIxMx+GrnlaKEhOL1MDCpPbw8BUFhgSMlg
 Thhe/INoPVAHu0vWSkcxYoRgcDj4k9EnklSbmnIkZw824m9ynO4yBXsHvq+/1vHDBga6
 /TgY3DuAirYp/AOm69UWiRUCzXIIWQ/+rDC0tL6hq3x+hw9r+CCojx3L8B09UWm3xVMs
 yG9dgI/AhS17EjznLm/lFIJcYfBInknRVpEF5RLe/E3F2wLzglzO7YEb4ShJlqQGneyU
 2F04MeBjy8MIMEHnZUnndpJukXSMbt05DMyBKYyTilxqetQ4ofvA1UnjN/Dqve5OfeFq
 85Qw==
X-Gm-Message-State: AC+VfDwxb4F95N6DHm2sgnu5O2NGqVbBltPO2+OuK5VgtUvl4TGN8IPu
 rBotQ7lIpugiQ5QYlDY71LxY9qbkRr1GkFADaAiqNWu2NYipGVG9
X-Google-Smtp-Source: ACHHUZ6A6pDbnE0Zx4DJcA4spQQAtVK4YknEni5OWO03UsS1gWczKhENNZ6EmGDw0Z0ay0MIgAt9q/zS+ojlcHNhAmc=
X-Received: by 2002:a05:6402:1e89:b0:514:af2b:4131 with SMTP id
 f9-20020a0564021e8900b00514af2b4131mr1906342edf.12.1685448803551; Tue, 30 May
 2023 05:13:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230525064345.1152801-1-lienze@kylinos.cn>
 <CAFEAcA_oP+cJL-HdzrS+R83=z8pYcrK-A3Aecm7NChdR4O3X1A@mail.gmail.com>
In-Reply-To: <CAFEAcA_oP+cJL-HdzrS+R83=z8pYcrK-A3Aecm7NChdR4O3X1A@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 May 2023 13:13:12 +0100
Message-ID: <CAFEAcA8hgOsqz1HtcNJ8GdTDhF9Aecjuxu4JB=S-zYZp1jA=nw@mail.gmail.com>
Subject: Re: [PATCH] Update copyright dates to 2023
To: Enze Li <lienze@kylinos.cn>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Thu, 25 May 2023 at 10:24, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Thu, 25 May 2023 at 07:45, Enze Li <lienze@kylinos.cn> wrote:
> >
> > I noticed that in the latest version, the copyright string is still
> > 2022, even though 2023 is halfway through.  This patch fixes that and
> > fixes the documentation along with it.
> >
> > Signed-off-by: Enze Li <lienze@kylinos.cn>
>
> Whoops, thanks for catching this. These are indeed the
> only two places that need to be updated (compare commit
> fd50a00a57509 which was 2022's update).
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>
> (One day I might try to get the copyright date to be
> defined in one place rather than two...)

I'll take this patch via target-arm.next, since I'm doing a
pullreq anyway.

thanks
-- PMM

