Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B0277D563
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 23:50:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qW1ud-0002JI-VM; Tue, 15 Aug 2023 17:49:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qW1uc-0002Ir-3w
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 17:49:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qW1uZ-00006O-TF
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 17:49:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692136150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F2ixuU1ZZcx1qZGkdmuJxxOMkb5aadrz2p9vIcp3cGg=;
 b=UXewqV3T4hQyFQbRqTeYLZGBHbcIyTabzMfOmzPOozDi6/KlVocqd06zmJZdBgmH2vaiSC
 eJf1dhecEb/8j+pUcv79V/T6t9/CRoKWfUBAzcO6+w7/ICT/2EcIEMNGt9GdGyMaKcEr3K
 f3duZjhEKMsFJLBAlZjynJkjYtsaCOU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-UTTkPfzXNB6t7ts9WGNw7Q-1; Tue, 15 Aug 2023 17:49:08 -0400
X-MC-Unique: UTTkPfzXNB6t7ts9WGNw7Q-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-63c9463c116so16498306d6.0
 for <qemu-devel@nongnu.org>; Tue, 15 Aug 2023 14:49:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692136148; x=1692740948;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F2ixuU1ZZcx1qZGkdmuJxxOMkb5aadrz2p9vIcp3cGg=;
 b=cbA8DUuqASmVp8E6UDAGaPoYRk5EmiFb4up8KlX+o3uypwZ1I1QEQVRzV9HLWvK/92
 icIOQf5uFcrYeCfuJQmJ9J89Wr80dbOZnTi3PPZ9AdT7bszhkekNZOyiocuVBOHnmqcl
 0FYgxSNEzjCReoVt4o4owNc0rhKKr38fbruaAKcH3oJfkB46lc8YrsC9BakGkmTuppTq
 bXefxq1FcGPuvGoO2iYdZ5K5ih0isdavEH2yMgA4aKyZ8u/Vnzl2b8L1V5AJMJXp+21x
 h/E9uOJ0I1+OQeYq39BE2EEd+GNko2xfYBlzubnetRcGOZw6Udp9yTv3P9MK2Rud/si+
 3gPQ==
X-Gm-Message-State: AOJu0YwqyWMzNR2uYzvOuXz6HE+tHH7SS47p9SRy18pFLg3XwuX/aiC4
 aCX9rG1HGFW7Dv3KtWvuVu8QNu/IH6OjKCN2s1+VPfKS+6hq8jp7Cl7wT3Av+9T7TmdaXjr9N9U
 HziFEn/KKmC3zAIc=
X-Received: by 2002:a05:6214:4015:b0:645:3c6:56ab with SMTP id
 kd21-20020a056214401500b0064503c656abmr34765qvb.1.1692136148259; 
 Tue, 15 Aug 2023 14:49:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNsOHIcDLNb+alq94MtIt6/k/O9nmVdrUaZfLbvmkO09mmT+FXblooPmARAtOFM1fgFMyW1Q==
X-Received: by 2002:a05:6214:4015:b0:645:3c6:56ab with SMTP id
 kd21-20020a056214401500b0064503c656abmr34750qvb.1.1692136147943; 
 Tue, 15 Aug 2023 14:49:07 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 d6-20020a0ce446000000b0063c71b62239sm4377262qvm.42.2023.08.15.14.49.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 14:49:07 -0700 (PDT)
Date: Tue, 15 Aug 2023 17:49:05 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Wei Wang <wei.w.wang@intel.com>, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v3 03/10] migration: Fix possible race when checking
 to_dst_file for errors
Message-ID: <ZNvy0cufhfL+pw89@x1n>
References: <20230811150836.2895-1-farosas@suse.de>
 <20230811150836.2895-4-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230811150836.2895-4-farosas@suse.de>
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

On Fri, Aug 11, 2023 at 12:08:29PM -0300, Fabiano Rosas wrote:
> diff --git a/migration/migration.c b/migration/migration.c
> index 0067c927fa..85c171f32c 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2057,11 +2057,10 @@ static int await_return_path_close_on_source(MigrationState *ms)
>       * need to cause it to exit. shutdown(2), if we have it, will
>       * cause it to unblock if it's stuck waiting for the destination.
>       */
> -    if (qemu_file_get_error(ms->to_dst_file)) {
> -        WITH_QEMU_LOCK_GUARD(&ms->qemu_file_lock) {
> -            if (ms->rp_state.from_dst_file) {
> -                qemu_file_shutdown(ms->rp_state.from_dst_file);
> -            }
> +    WITH_QEMU_LOCK_GUARD(&ms->qemu_file_lock) {
> +        if (ms->to_dst_file && ms->rp_state.from_dst_file &&
> +            qemu_file_get_error(ms->to_dst_file)) {
> +            qemu_file_shutdown(ms->rp_state.from_dst_file);
>          }
>      }

Squash into previous one?

-- 
Peter Xu


