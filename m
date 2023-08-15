Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B80B377D56A
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 23:58:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qW22d-0005lP-PL; Tue, 15 Aug 2023 17:57:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qW22b-0005gT-0J
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 17:57:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qW22Y-0002gl-Uy
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 17:57:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692136646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s6dpNkcBXSmYhd/ACR2WC+cuMp99bGp1gylheTe72I8=;
 b=Q1Z6Ml6ZXFbnX4u2jBfsk5G8hM58YSeufXrFwPi/4dbbPgTCMiiMhRXUbGES2mmRlPfyK6
 4McLFEIic8/ZeFE1kzR8IdZJ7eoEoUwyHZWhB52KSsrNJPaM0Z0g1QQ6urhyYxFJ5RnRzB
 6RmzEJIaPYyLIAZNbSD/q17cfJ8nBmI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-q2CggL9cPn2Wz2xqWMn8qg-1; Tue, 15 Aug 2023 17:57:24 -0400
X-MC-Unique: q2CggL9cPn2Wz2xqWMn8qg-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-76cf85654a6so145153585a.0
 for <qemu-devel@nongnu.org>; Tue, 15 Aug 2023 14:57:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692136644; x=1692741444;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s6dpNkcBXSmYhd/ACR2WC+cuMp99bGp1gylheTe72I8=;
 b=YCq79iwNksqNYAWVdCfzloJ59xQJXJ6xK2aY9XjdBQz1Av/pSRayOWXQRAXY0kaH5u
 O7lqI8IaYIJ1BPjqFWD1brByNmiorGqvZAq1CuW1+PYY1eb5s2XzM+NnX3zfugyIPbhA
 xfUNyZbByclDv6vzRQO77hwD7rI1juQcm3svsO+3cffuJWL/uTdds/gBMBVSdV34+Qfr
 dhuV1KN5iaFOSMENr/djdhCzwEsah+vIFcugrWkM5kGV4LJBDjUTO8WhKJUkKL5iaUdB
 TPEwI03i5JqVXT1vFqprQJfKil7m8W9ks94srzS74atfptZoAyiyYk/7mKxw6IqLTzvt
 UXvA==
X-Gm-Message-State: AOJu0YwgmN2UoyZlGVab7IvEH9zXTmkvolYU+XmT1DVWRPp+PWPvdsxH
 IdSlyUPkM4w5z0yG9U+pGaUKthwxfnlz0WSKvo1SH022SPcalaVzT7SYH/ZkSUgndQ04J1X6iHd
 AuI8hjpnAafsxbNQ=
X-Received: by 2002:a05:620a:4688:b0:76c:a3bb:f8c0 with SMTP id
 bq8-20020a05620a468800b0076ca3bbf8c0mr207022qkb.0.1692136644322; 
 Tue, 15 Aug 2023 14:57:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqvLaqF2HZcYpTS7NE0DGRgEweHMUVeC7Mb1NrDu3TiEmgCcG2hz+jDgc4bN6TIKoaybGHwg==
X-Received: by 2002:a05:620a:4688:b0:76c:a3bb:f8c0 with SMTP id
 bq8-20020a05620a468800b0076ca3bbf8c0mr207011qkb.0.1692136644036; 
 Tue, 15 Aug 2023 14:57:24 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 i5-20020a05620a074500b00767f00a9c67sm4027034qki.95.2023.08.15.14.57.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 14:57:23 -0700 (PDT)
Date: Tue, 15 Aug 2023 17:57:17 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Wei Wang <wei.w.wang@intel.com>, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v3 06/10] migration: Consolidate return path closing code
Message-ID: <ZNv0vZiyD8JQQRzI@x1n>
References: <20230811150836.2895-1-farosas@suse.de>
 <20230811150836.2895-7-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230811150836.2895-7-farosas@suse.de>
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

On Fri, Aug 11, 2023 at 12:08:32PM -0300, Fabiano Rosas wrote:
> We'll start calling the await_return_path_close_on_source() function
> from other parts of the code, so move all of the related checks and
> tracepoints into it.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


