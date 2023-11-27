Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F11177FA354
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 15:45:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7crc-0003w9-T8; Mon, 27 Nov 2023 09:45:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r7crU-0003jz-NK
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 09:45:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r7crT-0002tA-5j
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 09:45:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701096322;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=APhpttg4F6AAmBhE5PM9SU0+FGvxjb61D3OHyDM+HIM=;
 b=Q49q/j2Tu9dbTLJJXqOs9QxZQpHBae4JI7Mr+HkOkJtVghTnKbUW80yyTQ8P0aRDUM9Pxe
 odAvJ41f+VhCdFrAT1HWEkEbX+JmDPeGpfciR6cOecuEqvnKx0YVfataCP3ItjqgX3fHj+
 jCQwm/GwdQNUB4mK4o4UVJJRsyCcJvw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-SehpaoByMeuM228fx48ZuA-1; Mon, 27 Nov 2023 09:45:21 -0500
X-MC-Unique: SehpaoByMeuM228fx48ZuA-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-67a1f38b735so5878606d6.0
 for <qemu-devel@nongnu.org>; Mon, 27 Nov 2023 06:45:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701096320; x=1701701120;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=APhpttg4F6AAmBhE5PM9SU0+FGvxjb61D3OHyDM+HIM=;
 b=TzwtnPZGpLLrTlBxvAueI+x1MT8oUD0Bma1Ncir1e7GMxEGlitZh/y+Sbi0a3inu9A
 +lzAxQQsqf/q833SUvMaMNd+ssyokb6nucyDoTUjVLvz0lWUiWu2/ReCWq8wZnJ+t8dw
 nOHR13CkVCplB+2LhJ4lt8usrUk2dhgzqo4SWKPv0Qqud61mkKmy8TlHppQQWxea+QI2
 +NzrVShVcwHnHLBmmh+4sNcO4SOCu7i4R5SGytjjxmtD7lnHBkgcMXnm9/FVjIvm6ZLw
 IfxelCb6LaCfmfBmQuXCS/84mcF8Y3/M2gusqYNpmV+z5UJ7/iz+ZZPlj0pqxEExnN2d
 tzwA==
X-Gm-Message-State: AOJu0YxgkLmD9r8LLJhKOaLtpUsSOSZxazPs2T8W4PSzaQwwvfxsn5CL
 yirDMX1oBwjBqigB2Gz06YQASKT0dYxiHQYaA8e+DbXmkZI08O5Wsg0Y+4KAjiJPHvi7MNPApnu
 RlrwWF7r3pN1n4IE=
X-Received: by 2002:a05:620a:460c:b0:77d:5f90:36da with SMTP id
 br12-20020a05620a460c00b0077d5f9036damr13940251qkb.1.1701096320572; 
 Mon, 27 Nov 2023 06:45:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGok63oFPcAW9YtvbvWpfq+uqkzdiM5qFA6zi4ptt80UxQNF7ELoNuY+uVLmaWQ8JyO0+ZUdQ==
X-Received: by 2002:a05:620a:460c:b0:77d:5f90:36da with SMTP id
 br12-20020a05620a460c00b0077d5f9036damr13940223qkb.1.1701096320149; 
 Mon, 27 Nov 2023 06:45:20 -0800 (PST)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 qh12-20020a05620a668c00b0077d8dbfd1c3sm2244930qkn.79.2023.11.27.06.45.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 06:45:19 -0800 (PST)
Date: Mon, 27 Nov 2023 09:45:18 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v1 3/7] migration/multifd: Change multifd_pages_init
 argument
Message-ID: <ZWSrfoOYMDMNK8bo@x1n>
References: <20231124161432.3515-1-farosas@suse.de>
 <20231124161432.3515-4-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231124161432.3515-4-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Nov 24, 2023 at 01:14:28PM -0300, Fabiano Rosas wrote:
> The 'size' argument is actually the number of pages that fit in a
> multifd packet. Change it to uint32_t and rename.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


