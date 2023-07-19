Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD84759F5E
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 22:10:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMDTe-0008ID-7q; Wed, 19 Jul 2023 16:08:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qMDTc-0008Hq-RS
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 16:08:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qMDTa-0000oq-6b
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 16:08:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689797324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pQnseqF6Xuip4hd7ivXTR6czYLS7Rs1naN6RZfJ15Mo=;
 b=E1GYLNG0XKtQpCnYgIlE2FxW5YiNpesLIOEF2cbJgbXUvWPdS+CfkFxmf3iQXq1LHZLh2r
 Oeq1IzZu4Iu0IzISVHavf6fo8y4yQTyuiUMKtDcZSQllVQjVvzf+e8cRCB4UviFBHt9vVs
 kJfVHAtD3yT2mWqRx1N4rAZ3LzE7cFs=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-Im3sZtesM0iq8W2gbUe5AQ-1; Wed, 19 Jul 2023 16:08:43 -0400
X-MC-Unique: Im3sZtesM0iq8W2gbUe5AQ-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-635de6f75e0so123906d6.1
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 13:08:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689797323; x=1690402123;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pQnseqF6Xuip4hd7ivXTR6czYLS7Rs1naN6RZfJ15Mo=;
 b=QgZ26zW2yVntw4lbkJtJGlCCgfhDmNNBbJ1um0eLsONfc8S9wL6wGWZaBD5hhgBrOL
 UMwoO7B1KBRSIVLB8ovbngiaLjBA9yyZAEDjg+PAe7iTK1TtDPtBagxOw4UiBXMG+jEl
 0oiychcQ56GabNeGV3MoVCfznAp2ThZUhnZmOMA0BddxoJ4uUx0O3YV+dO35fa3z3RrE
 7wO3SE7rbhXlAyw7pl6rzvQhgvFMUqF4IkY2RX6XhecG6L46XFsi5S2YXpd8DNp57gLN
 9x3cxigfXwMQRarnJM+dINeKyF/h8wGXHjMRfn+IfnwMEjrEskL+1uvP+1bm4KKaE3L9
 kCmA==
X-Gm-Message-State: ABy/qLaaKy3g0OexYhf7V75TLkGLxkCYdyT55XyEfbIs/Qm5fKuK+6K7
 BrwEC/S3qFjNBvJZLr+jf1F7MMoa4Kw85NRKlXEU34m9fcsaL35KAaf2lsXNcn24k6jPe2l4C3v
 Qlq0iOav1verA7Lk=
X-Received: by 2002:a05:6214:f69:b0:625:86ed:8ab4 with SMTP id
 iy9-20020a0562140f6900b0062586ed8ab4mr357811qvb.3.1689797323062; 
 Wed, 19 Jul 2023 13:08:43 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHd/B1iYX0XqwpK4J9nZyHYSOTCRpnnIDxneaSQKDyy+PkFa6daTYJTfvETIkInt961HBhbIQ==
X-Received: by 2002:a05:6214:f69:b0:625:86ed:8ab4 with SMTP id
 iy9-20020a0562140f6900b0062586ed8ab4mr357793qvb.3.1689797322797; 
 Wed, 19 Jul 2023 13:08:42 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 kh18-20020a056214515200b0062fffa42cc5sm1671713qvb.79.2023.07.19.13.08.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jul 2023 13:08:42 -0700 (PDT)
Date: Wed, 19 Jul 2023 16:08:39 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v5 6/6] tests/qtest: migration-test: Add tests for
 file-based migration
Message-ID: <ZLhCxynbbTYvLb/c@x1n>
References: <20230712190742.22294-1-farosas@suse.de>
 <20230712190742.22294-7-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230712190742.22294-7-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Wed, Jul 12, 2023 at 04:07:42PM -0300, Fabiano Rosas wrote:
> Add basic tests for file-based migration.
> 
> Note that we cannot use test_precopy_common because that routine
> expects it to be possible to run the migration live. With the file
> transport there is no live migration because we must wait for the
> source to finish writing the migration data to the file before the
> destination can start reading. Add a new migration function
> specifically to handle the file migration.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


