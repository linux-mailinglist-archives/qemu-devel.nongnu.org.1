Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB7D82A622
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 03:44:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNl2g-0003Vm-Se; Wed, 10 Jan 2024 21:43:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rNl2e-0003VR-JA
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 21:43:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rNl2c-0002TF-N4
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 21:43:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704941013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5XMMNjPgKghHDLhVUuQKmQRnGlho/egv6tl4fIoGNk0=;
 b=OVCnvM6QE06o0w17hIClJkoIkyK7YntXPSTBNtfMzFXcfOSdgBKmiXqCoYd8AuKfoIuIRm
 zL5XNNVq2qBfdsIPG14IFRI7G/6FC028B4NKvRJZVBeO70zwe6DHTsPBmrxtuNvRvAd6JI
 uJ8SV+f1PFV+45nhqCTIJn9nysNzHw8=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-_KI5OI2pOFmVeu7kLCcbPA-1; Wed, 10 Jan 2024 21:42:51 -0500
X-MC-Unique: _KI5OI2pOFmVeu7kLCcbPA-1
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-1d53d51c62aso7549325ad.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 18:42:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704940970; x=1705545770;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5XMMNjPgKghHDLhVUuQKmQRnGlho/egv6tl4fIoGNk0=;
 b=Q2jMTegIihqb3et80xpmSzOO1GReNNbBHhLb8sCgWjZBfQpwB90cMChRS+rQEH6nBZ
 4sfexTQ8wFqwZYN9DwR3neViz9ojjOE677wD+8mqAGEyFNXaLK7CPi4kSGZY1VksMZQX
 0tewD4G86qOjyxXn652BWgCeaDLA/IxoqakQhkNhpFVrPY3l/H+lTox8TU2dA3rNa7Yc
 z/iikhBQL+7cJ2npaGb+9YDPFwKXbOw5ZxpBHRw3NBqkYRrnTpPiE66nJTrkxITIK+5t
 Rd3P9j3wCVWR7Uh78W4nLi9oZL+zrZuPXiIyQqQwH6RrgCaTVAI2DhqDVZH+wbUGjXIR
 3uIA==
X-Gm-Message-State: AOJu0YwHjgOAaqKr2ehKpZ/8S4ubCOBlrWS3ZH6/YRtoPjpOpN9Bb3Sy
 gQrzlrimqrvIZrBmJMaJ6yEFVJ6Gbmi4yCMRaGkAMv674b17bYTigSZHrw/jp5VfVj6CMOYp6fa
 IMgMnYv4ayiJ8396O2CJUidw=
X-Received: by 2002:a17:902:f54a:b0:1d4:e308:d6fb with SMTP id
 h10-20020a170902f54a00b001d4e308d6fbmr944922plf.5.1704940970128; 
 Wed, 10 Jan 2024 18:42:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHBIfREHi3cxpFrpTDodlDqSpYZeCdbu5hC5pfXdAlUkX4nAoXshelFsUAer1rHmBMC26PPqQ==
X-Received: by 2002:a17:902:f54a:b0:1d4:e308:d6fb with SMTP id
 h10-20020a170902f54a00b001d4e308d6fbmr944913plf.5.1704940969809; 
 Wed, 10 Jan 2024 18:42:49 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 jh6-20020a170903328600b001cfde4c84bcsm40337plb.141.2024.01.10.18.42.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 18:42:49 -0800 (PST)
Date: Thu, 11 Jan 2024 10:42:46 +0800
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Bandan Das <bdas@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 00/10] docs/migration: Reorganize migration documentations
Message-ID: <ZZ9VpqIj0cbjMADA@x1n>
References: <20240109064628.595453-1-peterx@redhat.com> <ZZ0kpnT741chs1np@x1n>
 <1644d352-7ced-4ddc-90a8-8190fe863e87@redhat.com>
 <ZZ4C08Jrb-76WHW9@x1n>
 <8f357390-5a65-458d-875f-7c5c11ce8abd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8f357390-5a65-458d-875f-7c5c11ce8abd@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.774,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, Jan 10, 2024 at 04:21:12PM +0100, Cédric Le Goater wrote:
> We also have a [feature request] label under gitlab and some issues are
> tagged with it. I wonder how we can consolidate the 3 sources : wiki,
> gitlab, https://www.qemu.org/docs/master/

Thanks for mentioning the gitlab issues!  This reminded me that we used to
have Dave looking after that from time to time, but it's totally overlooked
at least by myself..  probably we need to have some time tracking it.  On
the documentation side for ToDos, it's indeed potentially doable to already
merge into gitlab issues, then we merge 3->2.  I'll think about it.

-- 
Peter Xu


