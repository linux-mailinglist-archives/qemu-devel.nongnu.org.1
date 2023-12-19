Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE13818AD4
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 16:08:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFbhI-0002db-UZ; Tue, 19 Dec 2023 10:07:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rFbhF-0002dF-0T
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 10:07:49 -0500
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rFbhD-0008Ud-Ge
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 10:07:48 -0500
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-58e256505f7so3079527eaf.3
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 07:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702998465; x=1703603265; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GQIQQ82DMyJbTIVDnVWkhN5Cr1ubb7YiSidj76amkew=;
 b=NVTcvDDU5rXQ+ozDKxkKoiNHe9YGCnCSoV1C4po5ftvqcNtqqt/8Uh76P3+GV795d/
 88pfdLtPtCT9DXJH1ybNlZb92za9TA7V4tvVq2fK3YQWkm8JYkk2iPX+NIPYgotKsdRX
 Y/Sb+gowvrFwtGmEp0ozh0mEeSjabtmOleElXv52666tifQMWMRtqLrpapgUMHkh2WRq
 E2rBk0Nn37B79R/ovVhXlOanJRjoRVfErzeQBLfzWb2xJtf1tqyXntPmUhsAx9EW/Upa
 I7YBHjPRSXM0NIr742g/2VcpY/sQ35z93IkGy36cXNQF65MDQl5YhRsb7K1G93EebXd0
 U6iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702998465; x=1703603265;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GQIQQ82DMyJbTIVDnVWkhN5Cr1ubb7YiSidj76amkew=;
 b=bt3AQ/rUppkIsqycO7yF4JilDz2pcFgWJumqtGedEKjUbCiGMBBCkg1ubUozM0bTQq
 LywsVtGi4a0yKs/WrfIWotnYj6w72xcCMZVm68I57o6j4MIq/gn/ixiDLUQ5aA05C3UX
 aow5w5m8+UqUcqPkH6W2Jwwf7K+FhFwdF6aqmVGO2mqr30qB5Ia/4H6PFjR/UI2tRtkl
 Htva66kFchNyOUyzufPSyhdbddy7Dxqi0awKI0xup88/IOhBs52ZuJhYRDACCRkzQMKG
 C6S6UIrCycwjBZs6nFRzAyj5U6A74CggposvzS4qMB/Dz6YrWbgvdSagcYm2sLTdZ20d
 KGCg==
X-Gm-Message-State: AOJu0YwPqX23ThypG9Uvz0wpvYVrOnb03W492olyq+84Gl47nIoaF28h
 Vu+vlJ0Y1CKrlc1SKQ+1eT9VdXSvD005mvYvAN8=
X-Google-Smtp-Source: AGHT+IEutFwGDzkTUqy/tzCh02AGQR/Ok4L/b4PYtyQMKtzE1Caf33ModVjv0YbLl//DDWqk0MAhTIqqgZyRiltiEUk=
X-Received: by 2002:a05:6820:22a4:b0:58e:30f0:54f3 with SMTP id
 ck36-20020a05682022a400b0058e30f054f3mr14212988oob.4.1702998465641; Tue, 19
 Dec 2023 07:07:45 -0800 (PST)
MIME-Version: 1.0
References: <20231212134934.500289-1-stefanha@redhat.com>
 <87v88ujliz.fsf@pond.sub.org>
In-Reply-To: <87v88ujliz.fsf@pond.sub.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 19 Dec 2023 10:07:33 -0500
Message-ID: <CAJSP0QWLWLOegwsZMcufG0R4mgoVys8E=n9uVotM0Fk5bj+bPw@mail.gmail.com>
Subject: Re: [PATCH v2] string-output-visitor: show structs as "<omitted>"
To: Markus Armbruster <armbru@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, 
 Michael Roth <michael.roth@amd.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc32.google.com
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

On Tue, 19 Dec 2023 at 09:49, Markus Armbruster <armbru@redhat.com> wrote:
>
> Stefan Hajnoczi <stefanha@redhat.com> writes:
>
> > StringOutputVisitor crashes when it visits a struct because
> > ->start_struct() is NULL.
> >
> > Show "<omitted>" instead of crashing. This is necessary because the
> > virtio-blk-pci iothread-vq-mapping parameter that I'd like to introduce
> > soon is a list of IOThreadMapping structs.
> >
> > This patch is a quick fix to solve the crash, but the long-term solution
> > is replacing StringOutputVisitor with something that can handle the full
> > gamut of values in QEMU.
> >
> > Cc: Markus Armbruster <armbru@redhat.com>
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>
> Okay as a stopgap to unblock your virtio-blk-pci work.  Suggest you
> merge this patch together with the patch that needs it.

Thanks!

Stefan

