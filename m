Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A949B7CA0E1
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 09:40:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsICh-0000tF-KQ; Mon, 16 Oct 2023 03:39:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsICe-0000t0-6O
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 03:39:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsICb-0007Vb-3r
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 03:39:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697441987;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=rg+kjp7DB2+M1cqUad7PMgEiBLLifuIIeejf8B4s2O8=;
 b=TBN7nxpGFO+W1gLchysiOdUi2NGS+NU9HA2HJn5HwcuDrs5JX6LstCYuM3gRkk60YxNW7h
 GUiuauUUBZmtmGlnQUHeCkUDT4xsBRg+Mz/E+mOR553i6RGW38Gjni76M7soTpIH5b6ZwQ
 eFqn5LZWx2AlcZLWP6gm0rxezlo8DYQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-U6R2_71jOTKQndC96mMJJg-1; Mon, 16 Oct 2023 03:39:30 -0400
X-MC-Unique: U6R2_71jOTKQndC96mMJJg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-30e3ee8a42eso2654962f8f.1
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 00:39:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697441969; x=1698046769;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rg+kjp7DB2+M1cqUad7PMgEiBLLifuIIeejf8B4s2O8=;
 b=pd7SyLj4KrJ8wugLCNmVAh1jecHOabfHOjjPplvM+pXIrkpl28V4Nln6VYGAAEEvDd
 87Z8fM0DulHbzMDVHj45Aw/Y3Wr+mhgomJ3fYrnC1BX80lt0uPkfZcxOv+yKkcfnbDny
 DvD5IuJagdterqt2lqgNR/mtXTGhMUHUS523JVWYBgD/dLREQm9w+0PhQ5MUfwjLshFz
 hpQdFXkKaRt/b23bAO/w1f0CUraLjZDJnW/SsZXD4fq5ud7kwgvkKxljqRaTUfbZs5Fe
 K75+ZFeBJ5AzimyQztZ8joLHOA24Bb8wB1kZxQXDDtlTbSdMbTjKTCDyJePVvC0gJooc
 /Deg==
X-Gm-Message-State: AOJu0Yy/k4++3ShRdrQdBgf68a/EfcK1Dzcvyr65dksoWEedVsvX25p8
 ASXducGgjnfEo01y69zV97tOLF89rLoKmAjay3z9jxWpUhNfmp9alOEDenp+3TE2mcmbdWDYwjD
 kY/lgih/9Ef3P17c=
X-Received: by 2002:a05:6000:993:b0:329:6e92:8d77 with SMTP id
 by19-20020a056000099300b003296e928d77mr26438221wrb.51.1697441969707; 
 Mon, 16 Oct 2023 00:39:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLV/FUlk+un+JClY5CuzB34BEUs3AO6U6M/QwPzWGs1w33WhWSw1qXptB6qDyYWStUx/keCg==
X-Received: by 2002:a05:6000:993:b0:329:6e92:8d77 with SMTP id
 by19-20020a056000099300b003296e928d77mr26438202wrb.51.1697441969282; 
 Mon, 16 Oct 2023 00:39:29 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 w16-20020adf8bd0000000b0032d81837433sm13907490wra.30.2023.10.16.00.39.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 00:39:28 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>
Subject: Re: [PATCH RESEND 3/7] migration/ram: Remove RAMState from
 xbzrle_cache_zero_page
In-Reply-To: <20231011184604.32364-4-farosas@suse.de> (Fabiano Rosas's message
 of "Wed, 11 Oct 2023 15:46:00 -0300")
References: <20231011184604.32364-1-farosas@suse.de>
 <20231011184604.32364-4-farosas@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Mon, 16 Oct 2023 09:39:27 +0200
Message-ID: <87o7gz3tjk.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Fabiano Rosas <farosas@suse.de> wrote:
> 'rs' is not used in that function. It's a leftover from commit
> 9360447d34 ("ram: Use MigrationStats for statistics").
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Juan Quintela <quintela@redhat.com>

queued.


