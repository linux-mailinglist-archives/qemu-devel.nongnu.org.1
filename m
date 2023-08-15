Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B9077D564
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 23:50:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qW1vK-0002qD-Lm; Tue, 15 Aug 2023 17:49:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qW1vD-0002pM-ER
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 17:49:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qW1vB-0000JK-9z
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 17:49:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692136188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=17IQWLWnM9m7zkgn+FmcjF2gkKyStlKBASh8b4VZsE8=;
 b=QQn9tGdQdgTOMK3TaMlfWoIRQJxVsh0b4if5Jm760E9HfTIJ5VmLG4/mzet14DRt29lNqY
 +DLYgb2s9ZyiSXX5JkwJsQg/xvaieo+HsfgyhmbCP1pwWNGFDacXQs8kzyEH0c4CM4HA7V
 Tcxq4ggk1datYRFJb2fLvxTNRfGqC9k=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-V2pnNdPxNNCvtKjO3wXPPA-1; Tue, 15 Aug 2023 17:49:47 -0400
X-MC-Unique: V2pnNdPxNNCvtKjO3wXPPA-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-63c9463c116so16499146d6.0
 for <qemu-devel@nongnu.org>; Tue, 15 Aug 2023 14:49:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692136186; x=1692740986;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=17IQWLWnM9m7zkgn+FmcjF2gkKyStlKBASh8b4VZsE8=;
 b=BK5xlnxW/EcR0Ej5wuPeLxuVqYVyErVFxXKRIAwVAYn4mzZENRWdY6reTnTTElJ/4L
 ol5IzMfEYk74NErrHTeMJhVYq/TcGN8UGwTfWYzpyXVclDgEAz98CHCOwjCCvWUoA2/K
 oXqu4Rr9XcN4T/m9DU5dynGF+KcHrPUx7+A1KsveVGHvC8ryOtlwyFOESbhwEh1a+NHU
 SFueSXe3YSO/OJ6I/IY8nPIGEopDy8LLFLLW36QXGa5HN2xNysh+HrJbodbu7thN2arN
 6zU/gUqMR38gAsVt4vnVOmeQQCbeev62nydxT0NjpuU+OYQiaon0F18ErkLgZ/EfXyMe
 W9FA==
X-Gm-Message-State: AOJu0Yw7peCb3gSE2nPmMAU7ijj9HDOT0evBKcnB90IERlBTzv3SgzNV
 eiPdx28mfWCQBIKNNZT2r8zOvWWMVCPVqF9sPgkGX3M9UEh6LLM7e+U353gVUEx8HOC4qFE5hw6
 sc4Zk4iHmuQ5MG+I=
X-Received: by 2002:a05:6214:4015:b0:645:3c6:56ab with SMTP id
 kd21-20020a056214401500b0064503c656abmr36005qvb.1.1692136186654; 
 Tue, 15 Aug 2023 14:49:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtnBdbrebLsP1jW+q5y8t3vALR8nYBym2Jy4tXCA1ys4tyBFfrtaKj2ceKyx8Js1NqWu25iA==
X-Received: by 2002:a05:6214:4015:b0:645:3c6:56ab with SMTP id
 kd21-20020a056214401500b0064503c656abmr35998qvb.1.1692136186415; 
 Tue, 15 Aug 2023 14:49:46 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 t27-20020a05620a035b00b007678973eaa1sm4042457qkm.127.2023.08.15.14.49.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 14:49:46 -0700 (PDT)
Date: Tue, 15 Aug 2023 17:49:34 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Wei Wang <wei.w.wang@intel.com>, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v3 01/10] migration: Fix possible race when setting
 rp_state.error
Message-ID: <ZNvy7mOL9slzsNsY@x1n>
References: <20230811150836.2895-1-farosas@suse.de>
 <20230811150836.2895-2-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230811150836.2895-2-farosas@suse.de>
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

On Fri, Aug 11, 2023 at 12:08:27PM -0300, Fabiano Rosas wrote:
> We don't need to set the rp_state.error right after a shutdown because
> qemu_file_shutdown() always sets the QEMUFile error, so the return
> path thread would have seen it and set the rp error itself.
> 
> Setting the error outside of the thread is also racy because the
> thread could clear it after we set it.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


