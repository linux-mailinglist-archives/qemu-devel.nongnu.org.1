Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C5E835976
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 03:51:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRkOB-0007bw-BV; Sun, 21 Jan 2024 21:50:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <42.hyeyoo@gmail.com>)
 id 1rRkO8-0007bi-6Q
 for qemu-devel@nongnu.org; Sun, 21 Jan 2024 21:50:16 -0500
Received: from mail-ua1-x92b.google.com ([2607:f8b0:4864:20::92b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <42.hyeyoo@gmail.com>)
 id 1rRkO5-00027g-CJ
 for qemu-devel@nongnu.org; Sun, 21 Jan 2024 21:50:14 -0500
Received: by mail-ua1-x92b.google.com with SMTP id
 a1e0cc1a2514c-7ce55932330so242221241.0
 for <qemu-devel@nongnu.org>; Sun, 21 Jan 2024 18:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705891812; x=1706496612; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+cXLgPXYA5Fe6az71hac21hiFb2mTxJdrHHMfSV7PMA=;
 b=NQfV5IL5CeN2jIpdWClWE4eH0eafiic3YzQYDSX2C4Ev+F6Liqtqki33kxEjChqNz/
 0IQMCYo+kM2h7zECZQnVDyA+lvFPlxlwlgrbVdHyYqUp2KdjFdHyX00GyrormByw2Z+m
 Md0MQRbcXzwp4BoQGoYUPz2ptqYn9jd6q8y5w363NXTCIYbyIoAlP6eqQxF37B18i2wf
 jR8aDIgakkBYbd9QB2Vzw4ZqKgH3sRNlJg1AL/3dyFNlnwnWnwbxUr4wEcKWdbnGebdC
 TidWzKBQlUt7iE77s64+/s7K3NypR3RQU7nJTSzqdCCcdCTNktxZsUe2oURluF2rGIHE
 9dTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705891812; x=1706496612;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+cXLgPXYA5Fe6az71hac21hiFb2mTxJdrHHMfSV7PMA=;
 b=ozh8RGGZ7Ktu4m+YYybCU2jUOBPZqyibTuGG0mW1FDp7iWjCE9nLrBG/bflsd4jpsG
 0h30fvjqQ83Ur+hGt9cANGPo+rUPGs3BhV7JESheozDzMQx8j5eaVA1xaygUHQ3nkmUo
 HfCDSG7XMOuO+5QRGFRSwUquEXA7MUupMRkOF1dzKZav7uxoktYqKPmXlX3hfea/e/6W
 XO2evtsNqArHEE28msKaU9ob39HZBEEpOSa+2Kf7T7nzZGl+b1XNkBefTCW3ryQYa6nb
 JijDVAM1wAWhxPLzhpHa3Bfr4bo97Ygq74C9yLRh1JzfBlDWOswnmTUlEsc7NoF1LioU
 yQ6w==
X-Gm-Message-State: AOJu0Yx3jdNub+nHrUx2lc3jMVOzeVq0P51U/YyHm9Zu7OrevGj50eiz
 w8cc+rWQnoGmdoKMFfAOsUv0n8ZTsu83f9qpmsPi2M7Be3SCqe7Z7Tck9TTczzF4zTdnCB7PSNU
 4WnncsNkVqz7Qx0HXOqPmW9vmThg=
X-Google-Smtp-Source: AGHT+IEnsKtgEXI0mfVZDlHugltUuL7oafebGrrUgHYsrFVtdmNBjZVTMno7dA7/Qbi3SUy17YEEsz9hIJ12GXa4p14=
X-Received: by 2002:a1f:ee47:0:b0:4b6:f0c7:62e4 with SMTP id
 m68-20020a1fee47000000b004b6f0c762e4mr542083vkh.12.1705891811766; Sun, 21 Jan
 2024 18:50:11 -0800 (PST)
MIME-Version: 1.0
References: <20231222090051.3265307-1-42.hyeyoo@gmail.com>
 <20231222090051.3265307-4-42.hyeyoo@gmail.com>
 <20240109175358.00007c48@Huawei.com>
In-Reply-To: <20240109175358.00007c48@Huawei.com>
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date: Sun, 21 Jan 2024 21:50:00 -0500
Message-ID: <CAB=+i9QrmMMazcNvEhuwTNF+UZMHPQE=yT=RE+MJCUQO+QY27A@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] hw/cxl/mbox: replace sanitize_running() with
 cxl_dev_media_disabled()
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Fan Ni <fan.ni@samsung.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, linux-cxl@vger.kernel.org,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92b;
 envelope-from=42.hyeyoo@gmail.com; helo=mail-ua1-x92b.google.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HK_RANDOM_ENVFROM=0.998, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Tue, Jan 9, 2024 at 12:54=E2=80=AFPM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Fri, 22 Dec 2023 18:00:50 +0900
> Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
>
> > The spec states that reads/writes should have no effect and a part of
> > commands should be ignored when the media is disabled, not when the
> > sanitize command is running.qq
> >
> > Introduce cxl_dev_media_disabled() to check if the media is disabled an=
d
> > replace sanitize_running() with it.
> >
> > Make sure that the media has been correctly disabled during sanitation
> > by adding an assert to __toggle_media(). Now, enabling when already
> > enabled or vice versa results in an assert() failure.
> >
> > Suggested-by: Davidlohr Bueso <dave@stgolabs.net>
> > Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
>
> This applies to
>
> hw/cxl: Add get scan media capabilities cmd support.
>
> Should I just squash it with that patch in my tree?
> For now I'm holding it immediately on top of that, but I'm not keen to
> send messy code upstream unless there is a good reason to retain the
> history.

Oh, while the diff looks like the patch touches scan_media_running(), it's =
not.

The proper Fixes: tag will be:
Fixes: d77176724422 ("hw/cxl: Add support for device sanitation")

> If you are doing this sort of fix series in future, please call out
> what they fix explicitly.  Can't use fixes tags as the commit ids
> are unstable, but can mention the patch to make my life easier!

Okay, next time I will either add the Fixes tag or add a comment on
what it fixes.

By the way I guess your latest, public branch is still cxl-2023-11-02, righ=
t?
https://gitlab.com/jic23/qemu/-/tree/cxl-2023-11-02

I assume you adjusted my v2 series, but please let me know if you prefer
sending v3 against your latest tree.

Thanks,
Hyeonggon

