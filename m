Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 552F47263E0
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 17:14:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6uqs-0002Ft-0N; Wed, 07 Jun 2023 11:13:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q6uqp-0002FH-Qm
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 11:13:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q6uqm-0004uj-QN
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 11:13:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686150743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Sxi0rdN/oiOVPn22IbWPszGA19lCpFh0+pR45m0QThk=;
 b=FkmMeQASQU+2wDOH+qgIuu4Xk9JP3+WVaHS6rOc8GM8nWqaJj/zTNeu+Fv14s5drWVISRr
 Hrj1xaJarkHi5uI2tgfsYgqrbSADdWz9NuvCVrLF8WfZ/Ij3t5ZWvHrwuBAbBjCDVhVTnh
 riZ3UN2B5JCXxqWxDqxAVYAfr2QdOXA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-39Y7Y_huOhem2Pu1u7yWqA-1; Wed, 07 Jun 2023 11:10:10 -0400
X-MC-Unique: 39Y7Y_huOhem2Pu1u7yWqA-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-62632620f00so10412186d6.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 08:10:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686150604; x=1688742604;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sxi0rdN/oiOVPn22IbWPszGA19lCpFh0+pR45m0QThk=;
 b=drXpwaxfL2vcHqlcWQs41ekgTXAZppF0x43/pd6ky/7sxsvP8wSOwF4wuUYdEhPH+Q
 yK6S4k4IXFhPnc9LPlw5o4O+a9pSXqX8yoZza3YsgOOjQ9AjF7Q++HPwdnVs7TVyqXP+
 ILDAZTzBQzjtRdNRlLSg1qRw7Zes00aJxrC1eTuHkZGSn7ZHMMtcZyooCYLtsoDMHS8B
 rL3siShJx5oVGyVGsgzcjILTDHbHxdXg8knCM3JILfZtFgXg9KP2yZS5qMpcRoJ/gDwI
 yLofknVDNr3FUACYWh7UhONi7xUpuyjuHGJp8GtzxB4FDpWyd0p/Bp6DPH5/Rz5T6Y7b
 l4eQ==
X-Gm-Message-State: AC+VfDy3rKjXf9VRiX8NyjZ18298JL5bruDjJKYQtn9Wq/nc6xrQJOgt
 1qbT079dvtyJazbpAsCcZfZt/CDKGGODfortBIxz3vK6iUnWwOx8Vg/t9k2VUrp+QS4OMy2as/H
 G7VPydcFb27srabQ=
X-Received: by 2002:a05:6214:4014:b0:625:aa48:e50f with SMTP id
 kd20-20020a056214401400b00625aa48e50fmr2510447qvb.6.1686150604613; 
 Wed, 07 Jun 2023 08:10:04 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Sfvy741kwFT3FrB0vtWtbFKxRqNtsQ1Ft7bU3RZG9oMrp9nQuykj3EzDLid7YIR7OEq1K+A==
X-Received: by 2002:a05:6214:4014:b0:625:aa48:e50f with SMTP id
 kd20-20020a056214401400b00625aa48e50fmr2510426qvb.6.1686150604395; 
 Wed, 07 Jun 2023 08:10:04 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 pr27-20020a056214141b00b006262956aa0fsm6085350qvb.106.2023.06.07.08.10.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jun 2023 08:10:03 -0700 (PDT)
Date: Wed, 7 Jun 2023 11:10:02 -0400
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH V3] migration: simplify notifiers
Message-ID: <ZICdyhgXhvsBM5jM@x1n>
References: <1686148954-250144-1-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1686148954-250144-1-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, Jun 07, 2023 at 07:42:34AM -0700, Steve Sistare wrote:
> Pass the callback function to add_migration_state_change_notifier so
> that migration can initialize the notifier on add and clear it on
> delete, which simplifies the call sites.  Shorten the function names
> so the extra arg can be added more legibly.  Hide the global notifier
> list in a new function migration_call_notifiers, and make it externally
> visible so future live update code can call it.
> 
> No functional change.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


