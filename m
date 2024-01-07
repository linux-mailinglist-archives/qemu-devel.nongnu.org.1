Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CD282640B
	for <lists+qemu-devel@lfdr.de>; Sun,  7 Jan 2024 13:35:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMSLb-0004QK-Ms; Sun, 07 Jan 2024 07:33:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rMSLZ-0004Q7-NH
 for qemu-devel@nongnu.org; Sun, 07 Jan 2024 07:33:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rMSLY-0005w6-6P
 for qemu-devel@nongnu.org; Sun, 07 Jan 2024 07:33:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704630821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eygNhRoP2RWVk5Ug3YDJPfJYf9qQ/jEsBE/vcoLFGYU=;
 b=UM+CyqIs1kJf9r47DRj5d8pHCe1VtXaHo2dwLesUzW/2hOAsD94Jx90aZrG9LIVZjclzra
 wwyGl72IaWcANUvTDkH9WMprc53AgrB3XMd4MCPGxJzZHWEduhEsd3Dz6uSSUjG9LSIpJE
 1aqo2nAKDuNOBC/OKX9gl110/i/lCWA=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-DEa5S19xPfWNsH2Ka0VTHg-1; Sun, 07 Jan 2024 07:33:40 -0500
X-MC-Unique: DEa5S19xPfWNsH2Ka0VTHg-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-6d9bf77a474so420962b3a.0
 for <qemu-devel@nongnu.org>; Sun, 07 Jan 2024 04:33:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704630819; x=1705235619;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eygNhRoP2RWVk5Ug3YDJPfJYf9qQ/jEsBE/vcoLFGYU=;
 b=AEtvhZ3U/5HQ6Pa51w4EK9wC90x5eAtQndVAbL3ndvIp4IGFbgpozB4e+55i8RZN2a
 RGxijhJRLngaosvBdg4GPBBD1kK92xnfnmpnvINirCPmkBhq/rJfzJ9t1VVmYA7CddGR
 mel2xKmFcdarSdN3KJsSd0c8C9GFxtpqIbFFCNgUhVqiiLShUx3N2ykDTJVE5yP2J8MR
 t+eb96UtyXbkY/OPcyXxhvPyA7yOLHHitLl7IUgKjMFO3ONHlXGpNPrKryQtHeGqKd0A
 uz61SWqG4mtK2ctyF+ekagFbSEzN2z/+L72o8aW/xzW+OiD4f/SLPb5t8BRgpArLC+HW
 aXvg==
X-Gm-Message-State: AOJu0YxyxLw6dfifqYhi+35hR5Q2QH19DCQRodR4e5Jj2pEyNvd9p7Qb
 a9voMAHEK0GwBJriOHHHx6kju7Tl3cYzrD1Q9ITVcsXN+cM7UpNU9K+tK7mdNoPiYiBuCJRswPI
 RNufFiyY8fDBOUptbEYYSpQ0=
X-Received: by 2002:a05:6a00:2447:b0:6da:86e5:1648 with SMTP id
 d7-20020a056a00244700b006da86e51648mr4935284pfj.0.1704630819357; 
 Sun, 07 Jan 2024 04:33:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEqamcRcinZxjoR2u4vFfvdBR7pRB78RHaBZ4PwHGlAWGX1dT7XI7VEgg9xiy6J8I7fgn91ZA==
X-Received: by 2002:a05:6a00:2447:b0:6da:86e5:1648 with SMTP id
 d7-20020a056a00244700b006da86e51648mr4935260pfj.0.1704630819031; 
 Sun, 07 Jan 2024 04:33:39 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 10-20020aa7924a000000b006d9aa04574csm4289911pfp.52.2024.01.07.04.33.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jan 2024 04:33:38 -0800 (PST)
Date: Sun, 7 Jan 2024 20:33:29 +0800
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Steve Sistare <steven.sistare@oracle.com>,
 Juan Quintela <quintela@trasno.org>,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>
Subject: Re: [PULL 00/26] Migration 20240104 patches
Message-ID: <ZZqaGf6nt0wkZgbS@x1n>
References: <20240104043213.431566-1-peterx@redhat.com>
 <CAFEAcA8iim9vr19DxRDVabdESvcz+pAx91Ff6a7wQB-rrsCxqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA8iim9vr19DxRDVabdESvcz+pAx91Ff6a7wQB-rrsCxqg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.098,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Fri, Jan 05, 2024 at 04:08:40PM +0000, Peter Maydell wrote:
> I notice that your gpg key doesn't seem to be signed by anybody
> else; you might look at whether it's easy to get it signed
> by somebody else (eg some of your redhat colleagues).

Hmm, I think I have signed with at least Juan and Stefan.  Which is the key
server we normally use?  Maybe I missed some steps there?

Thanks,

-- 
Peter Xu


