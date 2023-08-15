Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B57177D5DE
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 00:21:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qW2PG-0006pq-Nw; Tue, 15 Aug 2023 18:20:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qW2PF-0006pf-2x
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 18:20:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qW2PD-0000sT-2e
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 18:20:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692138050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gPCmuH822usTR/z9FNvtOxoU5n4boUP5zdYJPHjK0r4=;
 b=QHhwVXMAeqU3+S8n0nYvfwwXX/Q+qoAFSvLtRJ0QIa+GG3NHc+D7R4Dl6D5XNsiBhyBos8
 geJ75cMTzx4rwZXf59ZFdMvmAXOOF4XZFqcmQ282ziS+g8RsfT2xYB5pM7ld7ADXeMCoRW
 OrgFAIQ5oTA7fab5JpO4Fm0mcwspvXg=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-zt_tuKtbOoiy3Yxj9nNjkg-1; Tue, 15 Aug 2023 18:20:46 -0400
X-MC-Unique: zt_tuKtbOoiy3Yxj9nNjkg-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-63d2b88325bso16553546d6.1
 for <qemu-devel@nongnu.org>; Tue, 15 Aug 2023 15:20:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692138046; x=1692742846;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gPCmuH822usTR/z9FNvtOxoU5n4boUP5zdYJPHjK0r4=;
 b=IfajLFKY1bgHVJpR4XMINfbo/0QB+TYz2WW8Ho1H0UIZrYB2X5TdJaiaegXrw9577Y
 5wH8GbH6lYSdaX55wpfDZwerUlgaN20sFyeKwQwvEZ+Y07FJ055aSjTa+76mVj1Yn+Rz
 7Nw64KGe1yxzm6o2HrUkr8DrrKb3NNe0cF/NwSdaQbCkuPDFnTb8A/Sn6x2y9HivpUyt
 gneqvtCZ6Lc7ruMl1z2pKKcXrcc7mwMO+TdLjQDg0LS4uFsvSzvP2d57O0C5LFOPj3oJ
 r6KJzjO1OxZFYAUKHDLFyEal70F/43+SKh2UxRizZcT7HnGRUO6AgzTx/hHW1YEGImgb
 Va3A==
X-Gm-Message-State: AOJu0YyaGhQu2C9oHRQxcZKB/gDMTC9tvF1TexSG78o8Tm6OauckFAaq
 cZ2dTbpG7nGDi24F7nMGQCNVFoASiRdL0YRgNNwjC4Ayt4G4KAwGRixSwJ+SUzoGfPiO9k1Vsnv
 7qgfmCckEqs1w9Es=
X-Received: by 2002:a05:6214:27ca:b0:63c:7427:e7e9 with SMTP id
 ge10-20020a05621427ca00b0063c7427e7e9mr70404qvb.6.1692138046363; 
 Tue, 15 Aug 2023 15:20:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsfoZm71KWTdT8Ly9zzIxL3OS2KOb4a4/5QmV5FNU4laWW/ElZWzX38RSmjaMVIyYs+2fEXA==
X-Received: by 2002:a05:6214:27ca:b0:63c:7427:e7e9 with SMTP id
 ge10-20020a05621427ca00b0063c7427e7e9mr70394qvb.6.1692138046154; 
 Tue, 15 Aug 2023 15:20:46 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 g4-20020a0cf084000000b006301d31e315sm4423481qvk.10.2023.08.15.15.20.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 15:20:45 -0700 (PDT)
Date: Tue, 15 Aug 2023 18:20:44 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH 1/5] migration/ram: Remove RAMState from
 xbzrle_cache_zero_page
Message-ID: <ZNv6PLV4KejweRvT@x1n>
References: <20230815143828.15436-1-farosas@suse.de>
 <20230815143828.15436-2-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230815143828.15436-2-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

On Tue, Aug 15, 2023 at 11:38:24AM -0300, Fabiano Rosas wrote:
> 'rs' is not used in that function. It's a leftover from commit
> 9360447d34 ("ram: Use MigrationStats for statistics").
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


