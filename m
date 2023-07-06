Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1756074A3DD
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 20:39:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHTsm-0007cT-Pk; Thu, 06 Jul 2023 14:39:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qHTsh-0007Rt-2x
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 14:39:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qHTsf-0005VD-EQ
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 14:39:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688668743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qt8pHKH/UsDvVXeulzj0TQoUnbnpuV0wJmbUQBCMyGs=;
 b=bI9Ah0jA/zQa5uW8PUQCeuIsI55G5fTiRsnrjRzNPP7FkhEYgXL565Epx6ByYJQbWqVqrj
 B73j9gs0HoidLsobp+2f11Mal09TJZv87v1UnQadDsoNveUSF2b3XMuCSyu8BclZeSvOM4
 28UZ3QHcGNfH18Lkg8MaYI6WMFWpAsI=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-KpuC9PmgN96EExjNRR292w-1; Thu, 06 Jul 2023 14:39:00 -0400
X-MC-Unique: KpuC9PmgN96EExjNRR292w-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-63656624620so2180116d6.0
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 11:39:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688668739; x=1691260739;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qt8pHKH/UsDvVXeulzj0TQoUnbnpuV0wJmbUQBCMyGs=;
 b=QJh21t+N6j2oPEpGjuUFVw8V06GcKiLBOdJPkw8btbrZW4QZ3mI8Ps8kAwJhou47s9
 1ffue4lQEjfy4hfU1u2nAZzraVkD0VfyODY+0twLPQDozXsuat27qfa0QOIvTQ1ZIQTR
 NvT0l2yArEJEOy6UhLe36Phjvo8VfPiZ1AvLw+Q/7W3+T8r0FPfFSF0kWHaAfRxTYXth
 6vuMDlYAryedyolvXc/2jYByJGsuzqnUxbie8YTkCLlVXHBDBjvWMnFIZ7uqS5gffUeV
 WIkgcsHyFFtT5DISenOrw+bOIgKOTguIT/+uFl/zFyDe0BpdGjAtuDt4Z5kvPvaGl6Ua
 h5/g==
X-Gm-Message-State: ABy/qLaxJhPELfwM3mv+MxLwSxKwq9fYXfF1OHMOMcdv/dZ1IG5HQG/p
 paEt0vjlmriM8HREONBm0bbaW7qym8LaBOHBWaHjtNf5vNWrwPLHyoSee/M83Tl8YUDjdbwOcvq
 Y0XW1hpfQMGGAL1w=
X-Received: by 2002:a05:6214:1d0b:b0:635:ec47:bfb0 with SMTP id
 e11-20020a0562141d0b00b00635ec47bfb0mr2700759qvd.5.1688668739650; 
 Thu, 06 Jul 2023 11:38:59 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH9cO356Kbpqp8Wm6ZuWqLXKB/v+6k6Pno9dNsoZjEv6jXjsdN3TwkwD80pWgQb8O6hNfBk/A==
X-Received: by 2002:a05:6214:1d0b:b0:635:ec47:bfb0 with SMTP id
 e11-20020a0562141d0b00b00635ec47bfb0mr2700745qvd.5.1688668739420; 
 Thu, 06 Jul 2023 11:38:59 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 t12-20020a0cb38c000000b006364a0caaadsm1166126qve.78.2023.07.06.11.38.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 11:38:59 -0700 (PDT)
Date: Thu, 6 Jul 2023 14:38:57 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v3 3/6] tests/qtest: migration: Use migrate_incoming_qmp
 where appropriate
Message-ID: <ZKcKQZTCqBg6XW4W@x1n>
References: <20230630212902.19925-1-farosas@suse.de>
 <20230630212902.19925-4-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230630212902.19925-4-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

On Fri, Jun 30, 2023 at 06:28:59PM -0300, Fabiano Rosas wrote:
> Use the new migrate_incoming_qmp helper in the places that currently
> open-code calling migrate-incoming.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> Reviewed-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


