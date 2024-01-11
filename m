Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D41482A77B
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 07:21:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNoRJ-0006EI-LS; Thu, 11 Jan 2024 01:21:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rNoRA-0006Ds-Vb
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 01:21:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rNoR4-0004N3-7I
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 01:21:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704954053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b9pTbPTTYwdc0VHl4C06GsC15HFQ0VPfRYyIxOSHxgM=;
 b=a7zHOGQQV40BSIJkev218CHeNHRK4xdcresrACuZgZCLZ6VScn9ulXd/0YsTDdiHz1Xvxc
 YGxhmlpElZvaP+e9LRjeeZvRghC+uskY20sREyBpmkgggV+83wDjoWKtPA0oW4Rq0h/3bD
 PAF147pgr9APFd2zIuKgZrxlbRY6SDQ=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-_PC8ubQkOAKqGzvrXSufGA-1; Thu, 11 Jan 2024 01:20:52 -0500
X-MC-Unique: _PC8ubQkOAKqGzvrXSufGA-1
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-6de00338d8eso356920a34.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 22:20:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704954051; x=1705558851;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b9pTbPTTYwdc0VHl4C06GsC15HFQ0VPfRYyIxOSHxgM=;
 b=olFi+CkU0mB0XgwkLnLergP4leLlmsA8K+KsuyMtiO1C3M3LVyx/0veRUxI2A33gWP
 jrUT5RPj5IdyjKMC/zQe0zaWC1tefZI/QhVQTJz1+SGdnmUw4g/34tcHwZMB/C0apj8Y
 GQ08IM7CHdOVWbATJ2oa+TR0UBUlmmyymUWJyjNHOeczWC74kudp4tMP/Vle3ava1c7D
 9DNwb7+jFpFFjd+XQn2Ss40+7y1X3flmf8ArEh9MdB2huGbifE5ap3N3k2Ycx4ma7TSH
 bNyUY8RshUkj2PeGEM+WR6GTiJhsAUUzAUEjqTNJVsX9G/CQb23ghbFrCzPf0Xjtvqmr
 3g6Q==
X-Gm-Message-State: AOJu0YxGNvFOPjwEOR48YZMN03ef6d7Pr1/vfpP4MD4sgL2R2U1dG7pN
 9ROoZ+J/oGYMIaFotAt8U2KV63thEfl30aCGV5LPoSlcAm12zbcDABZCoFHXbghqhCKKjnqJsU+
 GqLymOqgbNgn8UdpnGE2ht46fzLCiNZBDP4euDbHiAHf6xavRYk+qlclFhHj3qgCVRsKaFXGfaZ
 notzaE
X-Received: by 2002:a05:6830:4115:b0:6dd:e5bc:c6d7 with SMTP id
 w21-20020a056830411500b006dde5bcc6d7mr2110598ott.1.1704954051371; 
 Wed, 10 Jan 2024 22:20:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGCUB5LdFNdUpIaKRX5+vy+xFVVofQUJ8fPvu/CMcVAibEB3FemaJ3sfGXmf+tbimvBXdGJnQ==
X-Received: by 2002:a05:6830:4115:b0:6dd:e5bc:c6d7 with SMTP id
 w21-20020a056830411500b006dde5bcc6d7mr2110576ott.1.1704954051038; 
 Wed, 10 Jan 2024 22:20:51 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 z4-20020a636504000000b005ceb4a6d72bsm364094pgb.65.2024.01.10.22.20.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 22:20:50 -0800 (PST)
Date: Thu, 11 Jan 2024 14:20:38 +0800
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Bandan Das <bdas@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 00/10] docs/migration: Reorganize migration documentations
Message-ID: <ZZ-ItufGb9Udvxh6@x1n>
References: <20240109064628.595453-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240109064628.595453-1-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Tue, Jan 09, 2024 at 02:46:18PM +0800, peterx@redhat.com wrote:
> From: Peter Xu <peterx@redhat.com>
> 
> Migration docs grow larger and larger.  There are plenty of things we can
> do here in the future, but to start that we'd better reorganize the current
> bloated doc files first and properly organize them into separate files.
> This series kicks that off.
> 
> This series mostly does the movement only, so please don't be scared of the
> slightly large diff.  I did touch up things here and there, but I didn't
> yet started writting much.  One thing I did is I converted virtio.txt to
> rST, but that's trivial and no real content I touched.
> 
> I am copying both virtio and vfio people because I'm merging the two
> separate files into the new docs/devel/migration/ folder.

I fixed all the spelling of "practice"s in patch 5, and queued it for now
into staging.

-- 
Peter Xu


