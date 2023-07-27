Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3877654C8
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 15:18:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP0Uk-0007JQ-3I; Thu, 27 Jul 2023 08:53:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qP0Ue-0007It-Uj
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 08:53:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qP0Ud-0000zV-AC
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 08:53:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690462401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lvzK7Qd5T9nch4e+IYqu2cHIKZLmlHNqbDQzSOLOYY8=;
 b=aJ9HAsKLtLsDwEYxUfTCm2EOMff2ByObPPA2HlZMHiy8zb49BedoloqCy9+DMnhJBsyIST
 1uzXYDei2SsGv1nMYs0fJIlTe270pWM8xagk72nLZaTSyKa0jH3gjhOOlAW9YLG8KTU4AC
 rVIoOOVpXzBs5ZirCkSfUBjxbFwwxhs=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-vmHkyMlWMUmVbP_Vt_C_BA-1; Thu, 27 Jul 2023 08:53:17 -0400
X-MC-Unique: vmHkyMlWMUmVbP_Vt_C_BA-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4054266d0beso2268511cf.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 05:53:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690462397; x=1691067197;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lvzK7Qd5T9nch4e+IYqu2cHIKZLmlHNqbDQzSOLOYY8=;
 b=GEGZk49CaKA8G7byGksC5luztEWM/mOPCPyUr3/yoXA5ZE7cbq/a1Ma+5auUiXQsY6
 eiV1Xmm9JksqNee/zDFxe4dPSTAAyiHCYR95N2JpZ8lB1PjlYYhY3J3iM51HW9LMWPPZ
 ArnOTt0wVJEoYVS0HYWyoFS5Q/DC4gvF7+u2KX6ImXgbXjpKPjofZ8bbNhhIe50wQsT9
 PvyQNu0nSymyjmtveq41yGb2EZg7cDpOxO0Bbjyr9JNoiFV8krCtu/ymKhSCuIYAERXk
 J1GbxNPo+L0QuM+NvFsk7Z+QO53M7JanhZfpoYLNCl12qODikRlwQmfNC58RWQ4PP09r
 ymxw==
X-Gm-Message-State: ABy/qLbSAzqioj2MUEZHRNvN2/rh2msIkU+rJ/AAOXUuVVw1VgyxTmQK
 Hgibv3NM3HECOhj5IqNteakdJRVd+BOyplFPaVc4aVOBTwXBLo1+pXhTBhco3ANl9GlQ0DQAPZA
 Xerg8S1ll8PKzE1o=
X-Received: by 2002:a05:622a:1809:b0:403:ae76:12da with SMTP id
 t9-20020a05622a180900b00403ae7612damr6245383qtc.1.1690462397381; 
 Thu, 27 Jul 2023 05:53:17 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFAUSybR4sbo/WGdCiahkjJCsAKg3FWrHEEEjqYPVTsBbJPgK1FZUnApO0c3mbUt34GDxnvCw==
X-Received: by 2002:a05:622a:1809:b0:403:ae76:12da with SMTP id
 t9-20020a05622a180900b00403ae7612damr6245367qtc.1.1690462397156; 
 Thu, 27 Jul 2023 05:53:17 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 3-20020ac85743000000b00403b44bc230sm385781qtx.95.2023.07.27.05.53.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jul 2023 05:53:16 -0700 (PDT)
Date: Thu, 27 Jul 2023 08:53:14 -0400
From: Peter Xu <peterx@redhat.com>
To: hongmainquan <hongmianquan@bytedance.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, david@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [External] Re: [PATCH] memory: avoid updating ioeventfds for
 some address_space
Message-ID: <ZMJoumdi54neHzkC@x1n>
References: <20230725112037.1762608-1-hongmianquan@bytedance.com>
 <ZMFbxFnv82AWlzLD@x1n>
 <35f53340-dda3-c25d-41c7-b717da6a9121@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <35f53340-dda3-c25d-41c7-b717da6a9121@bytedance.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, Jul 27, 2023 at 11:59:43AM +0800, hongmainquan wrote:
> 
> 
> 在 2023/7/27 1:45 上午, Peter Xu 写道:
> > On Tue, Jul 25, 2023 at 07:20:37PM +0800, hongmianquan wrote:
> > > When updating ioeventfds, we need to iterate all address spaces,
> > > but some address spaces do not register eventfd_add|del call when
> > > memory_listener_register() and they do nothing when updating ioeventfds.
> > > So we can skip these AS in address_space_update_ioeventfds().
> > > 
> > > The overhead of memory_region_transaction_commit() can be significantly
> > > reduced. For example, a VM with 8 vhost net devices and each one has
> > > 64 vectors, can reduce the time spent on memory_region_transaction_commit by 20%.
> > > 
> > > Signed-off-by: hongmianquan <hongmianquan@bytedance.com>
> > 
> > Reviewed-by: Peter Xu <peterx@redhat.com>
> > 
> > Should be for 8.2, though.  Please always copy Paolo for memory related
> > patches.  I hope Paolo can see this.
> > 
> Thanks, I hope so. Also, I'm not quite sure what 'Should be for 8.2' means.
> Does it imply that there will be changes to this logic after version 8.2?

See:

https://wiki.qemu.org/Planning/8.1

We're already right before 8.1-rc2 release, perf patch isn't normally the
target of this phase.

Thanks,

-- 
Peter Xu


