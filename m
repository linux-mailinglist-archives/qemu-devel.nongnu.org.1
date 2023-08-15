Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4861677D569
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 23:58:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qW21f-0004z2-K5; Tue, 15 Aug 2023 17:56:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qW21a-0004yo-Ji
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 17:56:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qW21V-0002M1-OT
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 17:56:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692136577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/hFJwd/iPJZ2f21W7xl00k6a4Mv/O5xX2k4ToQznWzs=;
 b=GnQ+zHk54tjWyj62xfw1IphtNicTEdEBHdM35oLN9JyYe8pvD7yEiYTS1NNPIYdFlbNWnv
 PH+JcrbBean6QvUjfiCTywoOovBdajBqIRRBQ1RCqa+nMVl48r6sf/WaHhsYZLws9Ngp6M
 Yd2dtQMNdC4K4z8YWvCbULXGt1/yJRo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-pP5vaDTTMxqKI7Gx_5j59w-1; Tue, 15 Aug 2023 17:56:15 -0400
X-MC-Unique: pP5vaDTTMxqKI7Gx_5j59w-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-76cde638658so205616785a.1
 for <qemu-devel@nongnu.org>; Tue, 15 Aug 2023 14:56:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692136575; x=1692741375;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/hFJwd/iPJZ2f21W7xl00k6a4Mv/O5xX2k4ToQznWzs=;
 b=cr1m+KB0NCTsd57flzMKRbSiUrZ4XkrWYL9+H3pxOxv4GqX7+82knfwHCLU/U+20PE
 jnfDwfpMr/jMWavikFkbtPMViXRGu4iSUQCSbYRMIyZfs26CoO9tjbJWj7fTLLdDKFZF
 kN5vf1bk2XhiImx6Xyq8EjMh4irCBTsJpSdAJIK6GE5h71dfZo/C9qzT90GbGY2y0TEP
 JrleuUx4qeQ3YfCNYlPt1HjT69x4BPhzQ6/KnCJBXSvL0bmqoicK/j2PCOHqGC/swq4L
 0dEXGXwiike0LPXZFK9s+MXt6fpsSi9SZ6nrTMljRf8KGkSdmy15dulLccxrswIeOOSG
 fZFQ==
X-Gm-Message-State: AOJu0Yx+rsEPZU670ILHClRdwCngDvh5+4LQBKrb5oYy7W5OsOcjPs92
 J4Cl90K864VfnciJn7oVsOt6Y3WRUV5S6eJKwVNx3WjrsAmNFWO6nYrXLeYHGLprxVqjpj8Ipeo
 R62Ovb2g0cebOb6Y=
X-Received: by 2002:a05:6214:4015:b0:63d:2a0b:3f91 with SMTP id
 kd21-20020a056214401500b0063d2a0b3f91mr44147qvb.2.1692136575534; 
 Tue, 15 Aug 2023 14:56:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGv9o/tBxnllYuQ/tfmzO9p93Sm0rSPra7EMo3KUdu38Zq07q66YfsHEvHz86BUYyju2zUseA==
X-Received: by 2002:a05:6214:4015:b0:63d:2a0b:3f91 with SMTP id
 kd21-20020a056214401500b0063d2a0b3f91mr44139qvb.2.1692136575245; 
 Tue, 15 Aug 2023 14:56:15 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 r27-20020a0cb29b000000b0063cdcd5699csm4494724qve.118.2023.08.15.14.56.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 14:56:14 -0700 (PDT)
Date: Tue, 15 Aug 2023 17:56:13 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Wei Wang <wei.w.wang@intel.com>, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v3 05/10] migration: Remove redundant cleanup of
 postcopy_qemufile_src
Message-ID: <ZNv0fSV6J3KbAOBz@x1n>
References: <20230811150836.2895-1-farosas@suse.de>
 <20230811150836.2895-6-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230811150836.2895-6-farosas@suse.de>
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

On Fri, Aug 11, 2023 at 12:08:31PM -0300, Fabiano Rosas wrote:
> This file is owned by the return path thread which is already doing
> cleanup.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


