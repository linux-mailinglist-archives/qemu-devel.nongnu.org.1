Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC8375C560
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 13:03:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMnu6-0003GV-Iu; Fri, 21 Jul 2023 07:02:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qMntb-0003DM-Hj; Fri, 21 Jul 2023 07:02:06 -0400
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qMntR-00073B-N2; Fri, 21 Jul 2023 07:02:01 -0400
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-5636426c1b3so1147268eaf.1; 
 Fri, 21 Jul 2023 04:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689937303; x=1690542103;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tca5SpvqJRC5Tm0kXKLRvBpq2K2TIZXXkFQ//EoRHdM=;
 b=pa8P73bvxpXvmttUDTdV1sjf08HilehfJ8B6j+dgfOumL8KfUj8/IRF84DtEqhJAM4
 G2dEBh8azwzvpqrfjTstXfQFppLiXSEFCR0cY9v77n/uMshdnijGo7jtBPyiQJDlBpxE
 PHjX036HDBTD+YCP3e5dMZKBZ/btdHZcIa43dUoTecdAMyht2n/4GKS/cC9IX63DICCK
 emoJNZre24AHnl5l2YVNeznZx2f2zFhL9st/xKef8VKVBSLSNet5vKrB059Xh1L8KeaH
 //vpI6TIyqNvf7BzhgGrmACLoQ6qctZQSMHSUesUN19uxnUUmdFGeWQ7zJ+DqWoSIgdt
 PJYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689937303; x=1690542103;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tca5SpvqJRC5Tm0kXKLRvBpq2K2TIZXXkFQ//EoRHdM=;
 b=HRLcVj0FnD4/oPKvg6VKwSc7/6bHjph4FbSOl7uIyJNIFqVv73YcPdXcevBZUJWq6J
 S+KPPRmynYHh6X/dKSh0HkqzazvjBNKpI6euDC8VzOUMtg+NmySwRmnSmW6Edu24pBJ6
 O7FlBRGCB0z3cdBRj7iV/zIZDhTP5VBya68j95e1oTCtXWTV4QyHWe7fSyo4wi8vGC4s
 mpObdrp9pgyp43EMZn9p4Jn0IxwlRiqxVDp9JzLT8q6kXF58lL1vzuDZa6FxZjjE4jxZ
 NUow9jV0xHH6tjnoaNIHbzU90O9ND+PyFUtDtdSVxVraF8RlHwr1SeSbbuIcxpIjIR/W
 wScw==
X-Gm-Message-State: ABy/qLaCcOEQI8UZd0PAMjcx3y67cR2qK2SRUevNtDwAAQY848mzp975
 tAAT68GD3hWV6jjrQJc5eKPmKSuLTr6Y0GGhzu8=
X-Google-Smtp-Source: APBJJlH7sZpmpQe0Az0V3YbH5zkYLBq7UUn9EV7+de6Xl2zFXHR0rEcfSiuGH2KolEOyqXPHZZJ39//d2lqEhcIufRM=
X-Received: by 2002:a4a:6208:0:b0:566:ff47:2577 with SMTP id
 x8-20020a4a6208000000b00566ff472577mr1312858ooc.1.1689937303267; Fri, 21 Jul
 2023 04:01:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689899435.git.jeuk20.kim@samsung.com>
In-Reply-To: <cover.1689899435.git.jeuk20.kim@samsung.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 21 Jul 2023 07:01:31 -0400
Message-ID: <CAJSP0QU6Y0rDjb8Uy5KeST0kLfrAk7Hh8BKkoTnQ3_YhWyWSpQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] hw/ufs: Add Universal Flash Storage (UFS) support
To: Jeuk Kim <jeuk20.kim@gmail.com>
Cc: qemu-devel@nongnu.org, fam@euphon.net, hreitz@redhat.com, 
 k.jensen@samsung.com, kwolf@redhat.com, pbonzini@redhat.com, 
 qemu-block@nongnu.org, stefanha@redhat.com, berrange@redhat.com, 
 marcandre.lureau@redhat.com, marcel.apfelbaum@gmail.com, mst@redhat.com, 
 philmd@linaro.org, thuth@redhat.com, Jeuk Kim <jeuk20.kim@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c35;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc35.google.com
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

Is there a test case along the lines of tests/qtest/ahci-test.c that
exercises this new code?

It's important to have at least a basic test that initializes the
device and performs a write followed by a read to verify that I/O is
working. This will allow the CI system and anyone who modifies the UFS
code to check that the basics are still working.

Thanks,
Stefan

