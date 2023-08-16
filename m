Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A7377E51C
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 17:26:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWIPd-0005xF-Sv; Wed, 16 Aug 2023 11:26:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qWIPZ-0005kh-5F
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 11:26:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qWIPW-0001HF-V7
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 11:26:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692199573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tn5Q+cH9T0wyiAb0L3AlJ1t/MTomrjbCt7o0Hddka7Y=;
 b=EpuSKPyXQvdLT6hkvijB++j6Yg6GIpvrb5rJO1hxwwR+2lEO26spMKIRkKjfplyhy3qHas
 JnelLL+ON4RgjWfhtGCZmlCXcOfTClES/GKluAMngvkBtKGK9jYN4PihXckpP/S9LYUpwz
 HK1YHyIUPqktDSmxORBPMZ7BSFU+qjo=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-0fxcuSJWOdCVzpA7o-NQtQ-1; Wed, 16 Aug 2023 11:26:12 -0400
X-MC-Unique: 0fxcuSJWOdCVzpA7o-NQtQ-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-76cb9958d60so177289185a.0
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 08:26:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692199571; x=1692804371;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tn5Q+cH9T0wyiAb0L3AlJ1t/MTomrjbCt7o0Hddka7Y=;
 b=Eya18IZNfAIG+QqRqL4HllpUQtO2Y/S10HXaW3V+qWjjekdmm/V5I6X+INzAGIDUY5
 G47zPnoIcp9ckTdy0d/W/gTLqzEalBNA2ytdlto4baWufIdV2me8R1VRlTiR3SGo1hGg
 ElzJEzzVmAgNLg7m08qebCNKVGZtNJ1cnBTyAY7nAc23fbgbVIHTrRH0cw6XMaUxRAwH
 Cv4bXoUMLk4bqcq/gKFC+hwxO9qk2V5zZTHx9jjy5fZB5lF+NzJV/KLM9T/bWVcqFY9O
 URfiaTQFRXh+WHKRmhBmmy8fVa5bnZmg717GC//uj2Ofd+MWXobZPYaSvABrVaIK3q2L
 8cqw==
X-Gm-Message-State: AOJu0YzHbG/hUGwdJVkSv+QXl9nTYu6sqlTWFgn2QoWjO4Un4LMLlQtl
 qmQPaE7b5KL2lgFMdJzEokHlMM3KNUb4/G4YK9D3UUQzhTVrnP5IglK0K6QGMKcJVwz+ZMmyNvL
 QXTgx2LchSoiJ77c=
X-Received: by 2002:a05:620a:394e:b0:76c:fb54:93a3 with SMTP id
 qs14-20020a05620a394e00b0076cfb5493a3mr2686408qkn.2.1692199571735; 
 Wed, 16 Aug 2023 08:26:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4hD4cQPCBDe/cgmeKwE5Xc7aVl92hN8mYWgHGNJCK7tRXS8dK4rPVcMExqNsNHzoL7vQdLA==
X-Received: by 2002:a05:620a:394e:b0:76c:fb54:93a3 with SMTP id
 qs14-20020a05620a394e00b0076cfb5493a3mr2686395qkn.2.1692199571428; 
 Wed, 16 Aug 2023 08:26:11 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 p17-20020ae9f311000000b0076c94030a2esm4470730qkg.114.2023.08.16.08.26.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Aug 2023 08:26:11 -0700 (PDT)
Date: Wed, 16 Aug 2023 11:26:10 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Wei Wang <wei.w.wang@intel.com>, Leonardo Bras <leobras@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>
Subject: Re: [PATCH v3 10/10] migration: Add a wrapper to cleanup migration
 files
Message-ID: <ZNzqklRcsn/OSwDx@x1n>
References: <20230811150836.2895-1-farosas@suse.de>
 <20230811150836.2895-11-farosas@suse.de> <ZNv4/ndxGPpaIX9H@x1n>
 <875y5glyyn.fsf@suse.de> <ZNzcek7oqn+ccoQ+@x1n>
 <87r0o3kpbm.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87r0o3kpbm.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, Aug 16, 2023 at 11:57:17AM -0300, Fabiano Rosas wrote:
> I'm talking about the actual yank action, not the unregister.
> 
> migration_yank_iochannel() calls qio_channel_shutdown() in the same way
> as qemu_file_shutdown(), but unlike the latter, it doesn't set
> f->last_error = -EIO. Which means that in theory, we could yank and
> still try to use the QEMUFile.
> 
> In other words, what commit a555b8092a ("qemu-file: Don't do IO after
> shutdown") did does not apply to yank because yank didn't exit at the
> time.

Ah ok..

Perhaps we should register yank over the qemufiles not ioc for migrations?

-- 
Peter Xu


