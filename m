Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A26D82A7F0
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 08:00:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNp2T-0001KY-Eo; Thu, 11 Jan 2024 01:59:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rNp2R-0001KA-Az
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 01:59:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rNp2P-0000Tc-9r
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 01:59:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704956376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GsMZNI1jl8qd8IbkwK2nAyjuKceR/yl0z5Gg8PfFIAo=;
 b=McJ4p/ZIJ6NmShlSXAdpfbMXSZ6TGoiaDWGXT4ys3BRsZBFKDzifFc6KXlqN3jJKu374A5
 lvxLWaQF1I5F0Nan3m8sqhoe4dwvunye464Wy7Mh9h9m2ucsXcOrieLlA+gac2LRkr1uIA
 iZHjSMVD5MEdfYPcD8F7Z+uRZfkElbE=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-uk2B2WR7M8SNBYmHVTr9gQ-1; Thu, 11 Jan 2024 01:59:34 -0500
X-MC-Unique: uk2B2WR7M8SNBYmHVTr9gQ-1
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-1d53d51c62aso7839685ad.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 22:59:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704956373; x=1705561173;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GsMZNI1jl8qd8IbkwK2nAyjuKceR/yl0z5Gg8PfFIAo=;
 b=bxt5nc5o/pfAha8d3fPnmhbdZHVYaYuEMTss8H8rLzSnYrTFslZtfIAV8oo9RHu0dg
 I54uyKmleDt9RdjoDX7gbrhQqJXgM5BxgFIxwDWSUOk4CBDpjl+BJNWxF1s1AOy+X4Ui
 uDgD6qYXPWn1H+/PyKOSxWY4DUibUGjnie/vyghBMLVdTijC36iCxYpGvd+LxvUt/3Qu
 FUXLl2O3J1TbOgaKFxtwBp8HtmkKLJR3VT4V3AxDOkS+R1D0MhhpnkUxi4UacezRhl3N
 iOqDNiSEAOgyjkpK7tHSpg3lC3oLYv+PXml7dNYq1UmyjKiVZ8QwG/oeUPtA9HBn2q3f
 OLIg==
X-Gm-Message-State: AOJu0YwehOK6OGZSXWz/iJcnp9ADrc74Kwhg157gLiV+58ReI8qDQAzC
 ZkksNAPo+v3Qr7vS7tKvjN9XAQ6kmv08hfyqqBQLHK6Dhq5Qcc4c0jI6dS7zwqt7HmLxAAoZuHC
 VVYDqVnPnLwGEFUGrXMsePEg=
X-Received: by 2002:a17:902:f54a:b0:1d4:e308:d6fb with SMTP id
 h10-20020a170902f54a00b001d4e308d6fbmr1391909plf.5.1704956373130; 
 Wed, 10 Jan 2024 22:59:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQbsG5ml9XkXlT9pybWISaalnkoiybXNYLt55gn/Y73xLBhXcrv/F1qippX9D2BpodFGZe9w==
X-Received: by 2002:a17:902:f54a:b0:1d4:e308:d6fb with SMTP id
 h10-20020a170902f54a00b001d4e308d6fbmr1391891plf.5.1704956372828; 
 Wed, 10 Jan 2024 22:59:32 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 r19-20020a170902c61300b001d3e9937d92sm434740plr.51.2024.01.10.22.59.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 22:59:32 -0800 (PST)
Date: Thu, 11 Jan 2024 14:59:26 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Nikolay Borisov <nborisov@suse.com>
Subject: Re: [RFC PATCH v3 02/30] io: Add generic pwritev/preadv interface
Message-ID: <ZZ-RztCjEPyT44M_@x1n>
References: <20231127202612.23012-1-farosas@suse.de>
 <20231127202612.23012-3-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231127202612.23012-3-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.774,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Nov 27, 2023 at 05:25:44PM -0300, Fabiano Rosas wrote:
> From: Nikolay Borisov <nborisov@suse.com>
> 
> Introduce basic pwritev/preadv support in the generic channel layer.
> Specific implementation will follow for the file channel as this is
> required in order to support migration streams with fixed location of
> each ram page.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


