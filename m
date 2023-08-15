Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E1577D636
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 00:35:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qW2d7-0003rO-3i; Tue, 15 Aug 2023 18:35:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qW2d4-0003qv-UK
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 18:35:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qW2d0-0005fv-W1
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 18:35:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692138906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hqcUFw3eW7bUCvTtaNmc3WXYneYMddDi0LyVt/djmQc=;
 b=bsEE0nvnVIEBRXqCrH6+R6taUM7XhaPQWmq46p1cOW5cBXjWYVqYa3W5zvFUlmQFiYPXLe
 WeTqGfIjzHxKozh19eWSK0Nr6baG3RZ+NdG9zqXR1kfkFVlK5DG6z3K1rWstfzY/NuG/kL
 SxNmFkHt2e/d2W0LuzsRwqqErwtH6WA=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-iP05Fux1ODaMIbusUMg2tg-1; Tue, 15 Aug 2023 18:35:04 -0400
X-MC-Unique: iP05Fux1ODaMIbusUMg2tg-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-40fd74104f3so11222921cf.0
 for <qemu-devel@nongnu.org>; Tue, 15 Aug 2023 15:35:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692138904; x=1692743704;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hqcUFw3eW7bUCvTtaNmc3WXYneYMddDi0LyVt/djmQc=;
 b=HMbR4TldEwquALL/QwOd4D5ropFQtxcZ456/TSMPfW/pP08QuvrnPwwOybhDlihTEZ
 wEh5kst4F1fE0nimMkO/TWiZkxSfPN+/fcO9B8pZjEd+5cDJgBRbrj99rOGISQn6C4Ik
 DILj0/sYXr09L8m2E2J4FgcJhF2VUZeUgI+d/cdmUnTCzaQD/0L98qwIwwJKMQxWOhHO
 z3RDJCt4pWKrPWQwIxH7Lw1s9ReVpMopQh4+Yg7gjNuoSkUpBwO5vDAMHujcPlHWwhnV
 eSa4aeJTeEzhHZJY8avU8jFwu+MGzPnr3hOJOnwn7QVH2ZOFevAeQT86aILXCEcII1oQ
 ezLw==
X-Gm-Message-State: AOJu0YyRjFZkwoEjQfV8H8wQnjTW4DbTEElDBgOCZdor8DEMTuQgQ4xr
 3sr8v4q0t/3ev4QENd+qgwh0e2eGnMU9PtZlH0etqBLCNDTMvj+YZkzvDYg1YUwmOD3lv8J33Nj
 9sPizXHNUAQu6Td4=
X-Received: by 2002:a05:622a:198c:b0:400:8036:6f05 with SMTP id
 u12-20020a05622a198c00b0040080366f05mr133341qtc.2.1692138904077; 
 Tue, 15 Aug 2023 15:35:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKWEAexZczf1ae8BvVBX7EqI6YWqhFbzvlZCqIA+4dBS51rAXJmlfizC+ilV89e1UTTxsyVg==
X-Received: by 2002:a05:622a:198c:b0:400:8036:6f05 with SMTP id
 u12-20020a05622a198c00b0040080366f05mr133327qtc.2.1692138903828; 
 Tue, 15 Aug 2023 15:35:03 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 f19-20020ac84993000000b004053bcffe49sm4098802qtq.9.2023.08.15.15.35.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 15:35:03 -0700 (PDT)
Date: Tue, 15 Aug 2023 18:34:57 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Wei Wang <wei.w.wang@intel.com>, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v3 09/10] migration: Be consistent about shutdown of
 source shared files
Message-ID: <ZNv9kdLpaeeLCWKR@x1n>
References: <20230811150836.2895-1-farosas@suse.de>
 <20230811150836.2895-10-farosas@suse.de> <ZNv3Yx1qn84V2dYJ@x1n>
 <878raclzi8.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <878raclzi8.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.04,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Aug 15, 2023 at 07:19:43PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Fri, Aug 11, 2023 at 12:08:35PM -0300, Fabiano Rosas wrote:
> >> When doing cleanup, we currently close() some of the shared migration
> >> files and shutdown() + close() others. Be consistent by always calling
> >> shutdown() before close().
> >> 
> >> Do this only for the source files for now because the source runs
> >> multiple threads which could cause races between the two calls. Having
> >> them together allows us to move them to a centralized place under the
> >> protection of a lock the next patch.
> >> 
> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >
> > Logically I think we should only need shutdown() when we don't want to
> > close immediately, or can't for some reason..  Maybe instead of adding
> > shutdown()s, we can remove some?
> 
> Wouldn't shutdown() affect what the other end of the socket sees? I
> thought we used shutdown() before close() as a way to end the connection
> in a cleaner manner.

Not something in my memory.  Would you try to avoid shutdown() for whatever
we'll close() immediately with next patch?  I'd expect no change, but I'm
happy to be corrected...

Thanks,

-- 
Peter Xu


