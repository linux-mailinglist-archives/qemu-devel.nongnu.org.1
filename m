Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BFB77D565
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 23:52:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qW1xG-0003lY-RF; Tue, 15 Aug 2023 17:51:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qW1xB-0003l2-PG
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 17:51:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qW1x9-0001QQ-Ob
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 17:51:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692136311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VSRzS4SJmB7q6CpNFJw6YhvuQd+joqi/oJT23Td2aCs=;
 b=SdttYV/3QzJ/qdOJbPmvzwCh61IbRdn79I40mCQj//eKXBauTRmAA8kwJ3f75ITZoCmO+3
 qza/WKugpsSsCR44OeTM0k7eFK1HrX8tiAfsnhRj0BMJkcOByGlaRavi4o+vlMASyP1U2J
 n1uBq7QU9bynnJx1r+qsooJNXj9uFMo=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-kfd3B_xVO-KAmJSo54BDKA-1; Tue, 15 Aug 2023 17:51:48 -0400
X-MC-Unique: kfd3B_xVO-KAmJSo54BDKA-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-76cb292df12so206006685a.0
 for <qemu-devel@nongnu.org>; Tue, 15 Aug 2023 14:51:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692136308; x=1692741108;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VSRzS4SJmB7q6CpNFJw6YhvuQd+joqi/oJT23Td2aCs=;
 b=EIBSDb3PPIi/pj1l5RssTf7UAYXK/0r6ZaTGTKTb3xyuOymLNAbKDCdol24xGdZpPX
 uFPU3GCi4Nc/zQdv6CavWrn8BvcOiIJhB6mcm0sbZjQfx4KU4ZInx2E0p2bbaV63FRkD
 nM8nA25SxbTR66fCZrcDwbnWdTOQTfwLN5rc1EfGDqLkq4IiDsHw9VCxNJ6kgKsbhQnX
 VZj3Yfstd4LR7xa5RRUkNMEWZx6WZfg2Ekh+mreIvJto6UHvokUfdnvWLxPDvoBP7PLF
 SP2ZnpEH5hSpVC2S9lFPTopoCjkk8dIKgzPK7BOOeaBFV8BojnQPt1MQ+MqErkIQELPW
 l04g==
X-Gm-Message-State: AOJu0Yxq/laBd8e2+t39CsJMlTltzTqSmv05/il1GEHKnz518dBnzLaY
 KiqG+AKWgQbrcQj8atm/y18lEqwmF4DODDsgzRsmHK+m1UFyauXh64w4hfC4wwD+tUeqDoc0216
 anwMT+KXRcqigGD8=
X-Received: by 2002:ad4:5de2:0:b0:63f:ab71:69d5 with SMTP id
 jn2-20020ad45de2000000b0063fab7169d5mr7599qvb.5.1692136308414; 
 Tue, 15 Aug 2023 14:51:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdcJFc8wy09/4xRksGsKEAz33Wfmet8cWUVzyv/G+ikj7oKN1fC3yyp7Jl6V7ZiqHfHCiwfw==
X-Received: by 2002:ad4:5de2:0:b0:63f:ab71:69d5 with SMTP id
 jn2-20020ad45de2000000b0063fab7169d5mr7589qvb.5.1692136308177; 
 Tue, 15 Aug 2023 14:51:48 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 h14-20020a0cf44e000000b0063d38e52c8fsm4427050qvm.18.2023.08.15.14.51.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 14:51:47 -0700 (PDT)
Date: Tue, 15 Aug 2023 17:51:46 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Wei Wang <wei.w.wang@intel.com>, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v3 04/10] migration: Fix possible race when shutting down
 to_dst_file
Message-ID: <ZNvzckDALnMEN6pb@x1n>
References: <20230811150836.2895-1-farosas@suse.de>
 <20230811150836.2895-5-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230811150836.2895-5-farosas@suse.de>
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

On Fri, Aug 11, 2023 at 12:08:30PM -0300, Fabiano Rosas wrote:
> It's not safe to call qemu_file_shutdown() on the to_dst_file without
> first checking for the file's presence under the lock. The cleanup of
> this file happens at postcopy_pause() and migrate_fd_cleanup() which
> are not necessarily running in the same thread as migrate_fd_cancel().
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


