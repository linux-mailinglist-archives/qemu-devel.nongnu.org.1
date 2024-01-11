Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E90E882AC79
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 11:52:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNseZ-0006Eb-2y; Thu, 11 Jan 2024 05:51:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rNseW-0006EH-Vg
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 05:51:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rNseV-000641-CU
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 05:51:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704970270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8RHxM12FvFZx0NvlvEntya2M4eeaztzkVBeE6rIDCGg=;
 b=L6WGXJnTQ+O6haB77sCRoHGTSsOdlXoWx+Oznc2U1GwnS/vUp1FctTdpTaUQ52/vLvLq1u
 vRul0a8iG0uwNQiz0fE5cHshDuHicc+FeUis93Ri6V/BhZEBIgRV0S04UsGMBaRzy/8EJy
 NQ9S1oujeAriKV94OjgCnAvG3En7Yes=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-FWgorbRCPL-t3dhk8kEAIA-1; Thu, 11 Jan 2024 05:51:08 -0500
X-MC-Unique: FWgorbRCPL-t3dhk8kEAIA-1
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-1d44608e379so8442375ad.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 02:51:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704970267; x=1705575067;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8RHxM12FvFZx0NvlvEntya2M4eeaztzkVBeE6rIDCGg=;
 b=Juj4yChCYnTK/8vQpFBmC7XR9x7ihc99thnatmluja1cgJEC+ypl4leHM9tgxw/P/r
 HBHATsQp1H8/z5jrJZcki1cSaAojYHzU5J7SYTcfTX8k+SG513VzPJFN8sFeYhNlro07
 QQWYwHGkoIxOFvj8oWFV+9NfV5YUBtBss47qc+2NTb94N4yEDRKQTp+O8A/cPHXB9jZy
 QLlWbHJuyum1V/PCb7YhGXOaPU2dk2CLs0XYQcNQE/2v62OVeGkJuIbMXoKcDdP8/HZH
 0Pbh8hw502OdsiQoGFeIK+3fJuKwyhLqk63Uz9dZE1tK8IWiwhEt+1ny93ifVmy8kdeJ
 HXLA==
X-Gm-Message-State: AOJu0YwV1rzWa7IfmvmHoJi8oE7/mgJImafG2LbWX1SWsbTMgyXesXLS
 0n4zmZZr2bXFX4zGlknBph2+57MEdyGGag3H4gMlfwYgRXkVjg13oxubI9tHa1T+7g/RN0Djzhv
 tmNikr4yVVXbL4cbvdIwOp+Y=
X-Received: by 2002:a17:902:da89:b0:1d4:e308:cb0d with SMTP id
 j9-20020a170902da8900b001d4e308cb0dmr1841932plx.5.1704970267699; 
 Thu, 11 Jan 2024 02:51:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHgCf3tQ5RrS0gwIJTXxR+J4qtkMagRFHEWcSi/tFFQ9aKbd73YKvSb4JoNVBxbCQlXYcRQ4g==
X-Received: by 2002:a17:902:da89:b0:1d4:e308:cb0d with SMTP id
 j9-20020a170902da8900b001d4e308cb0dmr1841918plx.5.1704970267377; 
 Thu, 11 Jan 2024 02:51:07 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 y12-20020a170902700c00b001d3961217a1sm884912plk.102.2024.01.11.02.51.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 02:51:06 -0800 (PST)
Date: Thu, 11 Jan 2024 18:50:58 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [RFC PATCH v3 00/30] migration: File based migration with
 multifd and fixed-ram
Message-ID: <ZZ_IElHLW1D-lrec@x1n>
References: <20231127202612.23012-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231127202612.23012-1-farosas@suse.de>
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

On Mon, Nov 27, 2023 at 05:25:42PM -0300, Fabiano Rosas wrote:
> Hi,
> 
> In this v3:
> 
> Added support for the "file:/dev/fdset/" syntax to receive multiple
> file descriptors. This allows the management layer to open the
> migration file beforehand and pass the file descriptors to QEMU. We
> need more than one fd to be able to use O_DIRECT concurrently with
> unaligned writes.
> 
> Dropped the auto-pause capability. That discussion was kind of
> stuck. We can revisit optimizations for non-live scenarios once the
> series is more mature/merged.
> 
> Changed the multifd incoming side to use a more generic data structure
> instead of MultiFDPages_t. This allows multifd to restore the ram
> using larger chunks.
> 
> The rest are minor changes, I have noted them in the patches
> themselves.

Fabiano,

Could you always keep a section around in the cover letter (and also in the
upcoming doc file fixed-ram.rst) on the benefits of this feature?

Please bare with me - I can start to ask silly questions.

I thought it was about "keeping the snapshot file small".  But then when I
was thinking the use case, iiuc fixed-ram migration should always suggest
the user to stop the VM first before migration starts, then if the VM is
stopped the ultimate image shouldn't be large either.

Or is it about performance only?  Where did I miss?

Thanks,

-- 
Peter Xu


