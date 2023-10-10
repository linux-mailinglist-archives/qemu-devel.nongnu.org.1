Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 793187C011C
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 18:05:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqFAM-0004av-3m; Tue, 10 Oct 2023 12:01:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qqF9s-0004Oq-FO
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 12:00:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qqF9i-0001sI-Dt
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 12:00:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696953621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rTdsUx0RKzza6xfoO6nlEm/7r0PPcWDsIhghW4Mvzfs=;
 b=e7nsErXQdQbgKGEplbJez+sIalpQU0XGjg/F2/tY/+sIRHvEm+cFOqVQ1dK5DCsz2WzgAJ
 y4/crsbwTyF8PTwTU7Xi0rFbNLaX9wqL9u9HhpLm9MeNn4rD68TjN/KB1broWlw8hGcZf9
 arHCQWlYvKXENG8G+Y4NqSnYknXkv/Y=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-0RxiNtwiN_WhSVgjyCTSAw-1; Tue, 10 Oct 2023 12:00:19 -0400
X-MC-Unique: 0RxiNtwiN_WhSVgjyCTSAw-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-77585a78884so130109885a.1
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 09:00:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696953619; x=1697558419;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rTdsUx0RKzza6xfoO6nlEm/7r0PPcWDsIhghW4Mvzfs=;
 b=xLDKQH7/4DOyHmmcfBELbe4urelK43YBqEXAFrGHOWP7s4Ta9Be3eGBlEC5z0/IBWW
 bXP9cXBf37216zEHswiRWrgWR+mnxBH2BJo9+otaiDP9d9EKZzWwOHg9LSem6piDcVb+
 unKDZrJC3a2FItobPUhIOVj1zZmsgr0tFoXGd6zNkz2IgC5xprgflUx/yAirKRNduX8E
 2bwoED2mJo8EZTUUsIEeT3QfFiWk6fo9X4LBE5y4zGyIOjrAZUsMfDHxQKcht7hhFp59
 UkCyfbEYNySjMBsxJ+eoV4zNrIzez98nLRi7yI24H28EtGQs8HP7WrIaxaFTYYyxI4TL
 3Pew==
X-Gm-Message-State: AOJu0YwUPxfk/MhrYDpchJUN68vcHj6O5jdLq22kD3LzfJ9uufzEoc/m
 WY1p4VeitZ87UiN8nIqXetdpjYlukfbQkykowvxvyBk0Ww83aYlJBw1Sqc6qN4oSoHe4BTJ1IAd
 xvEJRPQ1eUsF98wQ=
X-Received: by 2002:a05:620a:372a:b0:775:c335:20dd with SMTP id
 de42-20020a05620a372a00b00775c33520ddmr21498302qkb.5.1696953619174; 
 Tue, 10 Oct 2023 09:00:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcuPc8uS/VJt84NWKV/SRNaC291G5Er/Ey4Et38IAPziu+dv7FvrMJoKU9SkWgOOTYwQ7RLQ==
X-Received: by 2002:a05:620a:372a:b0:775:c335:20dd with SMTP id
 de42-20020a05620a372a00b00775c33520ddmr21498273qkb.5.1696953618799; 
 Tue, 10 Oct 2023 09:00:18 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 oq25-20020a05620a611900b00774376e6475sm4439685qkn.6.2023.10.10.09.00.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Oct 2023 09:00:18 -0700 (PDT)
Date: Tue, 10 Oct 2023 12:00:16 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH v3 10/10] tests/migration-test: Add a test for postcopy
 hangs during RECOVER
Message-ID: <ZSV1EGTv0V8mi/5O@x1n>
References: <20231004220240.167175-1-peterx@redhat.com>
 <20231004220240.167175-11-peterx@redhat.com>
 <87edi9fbh5.fsf@suse.de> <878r8hfavf.fsf@suse.de>
 <ZR8iwwOeXWI+x9YX@x1n> <875y3kg4hv.fsf@suse.de>
 <ZR8uMcN5WwA2kC9k@x1n> <87zg0wenkg.fsf@suse.de>
 <87wmvveo5b.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87wmvveo5b.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, Oct 09, 2023 at 01:50:08PM -0300, Fabiano Rosas wrote:
> It seems to have fixed the issue. 3500 iterations and still going.

I'll go with that then, but feel free to report whenever that's hit again.

Thanks a lot.

-- 
Peter Xu


