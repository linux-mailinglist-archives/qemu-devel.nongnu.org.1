Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5AD7B82B9
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 16:52:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo3Da-0000KI-Rf; Wed, 04 Oct 2023 10:51:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo3DY-0000K6-Hs
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 10:51:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo3DX-0001Ps-7q
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 10:51:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696431074;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=xDwUSw9wzuh0JLosH6UP6+vKSU4EQZgCUe4Qi+PMsYk=;
 b=gNZMt2CUs0GrkZDlvLTeDKfG4qd6hzlUnsGr/sNoq5jOvXivfndQSzO7BqA1UANJYUDAr0
 LIktEnRiiKuOXIqCFcR1+vDJtSxRm0tGUoWWfTmuL8aACYAk1PolPv7VIH7VSwXSGjZPaj
 Wm1ceH/lO5yUJnBpzRwwhFqlL/ruNtE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-tj2N7D2PMKGm-3h6ANjbwg-1; Wed, 04 Oct 2023 10:51:02 -0400
X-MC-Unique: tj2N7D2PMKGm-3h6ANjbwg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-321f75cf2bdso1542347f8f.2
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 07:51:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696431061; x=1697035861;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xDwUSw9wzuh0JLosH6UP6+vKSU4EQZgCUe4Qi+PMsYk=;
 b=MDKDLvTsAMN5Np07PKiR83D176U3d3TXG4SiTNshZxnP0xl9vn5/1rwJRZZhG1LnpB
 4s9GJjK1TJUGOp/Aoc0LV14ouxJe+aP+kakEd+nMP9vdb7yTuEjC+fMz4az2pwmCEMQQ
 H5iA74RGX0XFUMUGqbNa+aZvC95Foc4thnZ1KfESatXIfeP95k7EWXvPZ51XgV5EhIKO
 v5uz7FVea9yimauBCVKaCDWOC3rxsrpysa2kFUrMUGFeSSV+zx5ctQK7q9hKk+S+s1oo
 GN+4H5NVq0kQF61+756aK4g9YG9pitAxqIVeO/zWep2n7OeaMRrMYqeRrmmtpSSr7qnw
 DOHQ==
X-Gm-Message-State: AOJu0YyUkTU5CJovb+qMcompaCqnEW89wb1GcU3JJX8M/us29aFKKT7o
 vRhuZCxGNMeoTpzDBqeIIRYmAiRQljIAbMqgA00zznWX00so2AGwoDKFNLkFcMkhzUh3zhwtDIn
 oidhk69fGplDAcyo=
X-Received: by 2002:adf:e491:0:b0:320:b2a:4ea6 with SMTP id
 i17-20020adfe491000000b003200b2a4ea6mr2137680wrm.9.1696431060903; 
 Wed, 04 Oct 2023 07:51:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWj/1G2AU4dOW38ic2g8WL0FFyf1cvyokV64ca3ldT0EEhzOKrPC9sLgg1Dsiz0kbN6kg32g==
X-Received: by 2002:adf:e491:0:b0:320:b2a:4ea6 with SMTP id
 i17-20020adfe491000000b003200b2a4ea6mr2137666wrm.9.1696431060543; 
 Wed, 04 Oct 2023 07:51:00 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 bf7-20020a0560001cc700b003140f47224csm4164122wrb.15.2023.10.04.07.50.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 07:50:59 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com,  leobras@redhat.com,
 farosas@suse.de,  lizhijian@fujitsu.com,  eblake@redhat.com
Subject: Re: [PATCH v2 08/53] migration/rdma: Give
 qio_channel_rdma_source_funcs internal linkage
In-Reply-To: <20230928132019.2544702-9-armbru@redhat.com> (Markus Armbruster's
 message of "Thu, 28 Sep 2023 15:19:34 +0200")
References: <20230928132019.2544702-1-armbru@redhat.com>
 <20230928132019.2544702-9-armbru@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 04 Oct 2023 16:50:59 +0200
Message-ID: <87bkdezbjg.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Markus Armbruster <armbru@redhat.com> wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


