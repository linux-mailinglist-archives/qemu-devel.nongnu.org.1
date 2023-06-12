Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8925572CEAD
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 20:45:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8mWz-0005jr-GH; Mon, 12 Jun 2023 14:44:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q8mWt-0005jO-5U
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 14:44:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q8mWr-0003F4-DF
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 14:44:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686595475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jF3Y2EIozxjY37HcJikvZf1inn50vrqWnwaz9bJqDu8=;
 b=XU5i2ebcFtHBkOJt/tALgbVuuBMP7A505TZHgLUafV/RmZBuLbDqHho1UtpwQKrXe/Cgaf
 K/KTnnaC/GpgE2n9X+DeQ9G8ZnPLvaNcl/K/KKBokfIy1zalffp3GX5jBy5iK0nI2veurv
 0j7077FqO35wYonYtQO7/yXs+hTnFYo=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-n_ESAQhbPhGiTDl9TYeiYw-1; Mon, 12 Jun 2023 14:44:33 -0400
X-MC-Unique: n_ESAQhbPhGiTDl9TYeiYw-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-75ec325d255so57228685a.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jun 2023 11:44:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686595473; x=1689187473;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jF3Y2EIozxjY37HcJikvZf1inn50vrqWnwaz9bJqDu8=;
 b=IZe3SjUmk9zsgDvYPoRH5wnTI8enYJQWLzma4MAtlOTy5w6G9HBE52W90HmO7bV0jV
 TnidzIiV4OmGSqDFsJ2JDzRSOmmVxd/0pKnDbGaMxi9Wi24uC+em3QDOlDlkgG8fWLBb
 CrhleLxia/qLJtZJ5VZQCBfvqPc62Fg1ac6gF39QnvdcvD8KuK6wr5Ci4YvEPSnMF0bL
 SIUAHKLB0wIc/RB/Hu3BrA+PxFhS6hKAtp8hPeUpdO/UPTADAEPZM+hOlgWTxcq8bo3T
 t6YAEIcuzFwez964HImZ9UjGBXOMaYgCZw2pdYQ7v3ub94S5+CTp9axy6MgK37swL6bN
 Ks9A==
X-Gm-Message-State: AC+VfDynbHjYb1n90BGWhJYsE4f/4vyRJ8g85EeVGzZOgQuBydjiP5Ms
 ypBnDD1OJs1Gi/7Roeo1erFroNecRzaURjNZTmPRxr93vtm5vDa1LIW49ay/vemRa3d770xL/AX
 fgzuCL2X5ZmRnTcc=
X-Received: by 2002:a05:620a:6745:b0:75d:5259:1f87 with SMTP id
 rq5-20020a05620a674500b0075d52591f87mr9356921qkn.7.1686595473349; 
 Mon, 12 Jun 2023 11:44:33 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6KqIFjm6p+GDLrDeLGdp7tHM+P7CN0yISZMALdlRQeumcZGxtrJGzWtH94oyxXNWuUjaV2HA==
X-Received: by 2002:a05:620a:6745:b0:75d:5259:1f87 with SMTP id
 rq5-20020a05620a674500b0075d52591f87mr9356911qkn.7.1686595473153; 
 Mon, 12 Jun 2023 11:44:33 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 c2-20020a05620a164200b00759322a6089sm3069154qko.14.2023.06.12.11.44.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jun 2023 11:44:32 -0700 (PDT)
Date: Mon, 12 Jun 2023 14:44:31 -0400
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH V2] migration: file URI
Message-ID: <ZIdnj7Hr1L3iDVUG@x1n>
References: <1686163139-256654-1-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1686163139-256654-1-git-send-email-steven.sistare@oracle.com>
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

Hi, Steve,

On Wed, Jun 07, 2023 at 11:38:59AM -0700, Steve Sistare wrote:
> Extend the migration URI to support file:<filename>.  This can be used for
> any migration scenario that does not require a reverse path.  It can be used
> as an alternative to 'exec:cat > file' in minimized containers that do not
> contain /bin/sh, and it is easier to use than the fd:<fdname> URI.  It can
> be used in HMP commands, and as a qemu command-line parameter.

I have similar question on the fixed-ram work, on whether we should assume
the vm stopped before doing so.  Again, it leaves us space for
optimizations on top without breaking anyone.

The other thing is considering a very busy guest, migration may not even
converge for "file:" URI (the same to other URIs) but I think that doesn't
make much sense to not converge for a "file:" URI.  The user might be very
confused too.

-- 
Peter Xu


