Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F3577D5E3
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 00:26:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qW2UO-0000IF-Qo; Tue, 15 Aug 2023 18:26:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qW2UM-0000I5-Li
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 18:26:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qW2UH-0002pr-EX
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 18:26:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692138363;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+Q3KpHTc+xOuXG8YQLPuD414DgUGoxF/RisS5qTG/jc=;
 b=O0c2oWgxU6eBvBH+aNLF5sbgPdhu3AlJaD8uJ9tU1PfynN3s9yj3rkV9/LEzCz2xLGMSip
 xtvNV6vjaZ+l81Bbtn9DkV+9X5ep4hSJATTXCXM8JkK5r7PQRJ94mw+JwnhD/qdJbyWGMN
 5Lzz8I61rMNhxS5IpdAtBLc2hXqDO+Y=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-H48saCx6NB6Mj6pw038FhA-1; Tue, 15 Aug 2023 18:26:01 -0400
X-MC-Unique: H48saCx6NB6Mj6pw038FhA-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-76c7cffef41so160728485a.1
 for <qemu-devel@nongnu.org>; Tue, 15 Aug 2023 15:26:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692138360; x=1692743160;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Q3KpHTc+xOuXG8YQLPuD414DgUGoxF/RisS5qTG/jc=;
 b=jDjkmMfJLQMaUErskS5QfkOiIaCxHZbwjdnLJkLUA0AF47FspvHHcfStcUy4ToC6mu
 FrST918LnOtwCpHtmGMLKnOE9SN1XMLBLhEYORXqbSv6B3eBV4yhsK2/7LguQa6iz35H
 QvjXBvYS8MOqvBgUC9Tys/MF0y0TwIfhOLU64KFlaVlhE7+icJz7I9j9I1L4en+X9XF8
 e5gHyOT0QnBxO5Rqm8KFZWwQg1cqu4u11+APBr5py/0xS0hJHhbILBXUFgU0PaMNG4YQ
 TPdJrIuhvEgSd4YSwyD7TI/57+6PL5WSrnReFrJdwmQpTm4lP3Xb/qQdi9lZcvOIgCFr
 ZZ2Q==
X-Gm-Message-State: AOJu0Ywc7Gjr5PKA6L2VL7vaTG6Wr31Uk3u0vx8UwFN/74XPNBdQH5hG
 BTwMlzqQISnpAS6uXC/VrebJsvDs6qnD1EYs9kxr02KN4/ulLubTd4XUfFTzw6NqIgsMIDeFLJH
 VtHSmCcoWzg8uffs=
X-Received: by 2002:a05:620a:394e:b0:76c:fb54:93a3 with SMTP id
 qs14-20020a05620a394e00b0076cfb5493a3mr238889qkn.2.1692138360742; 
 Tue, 15 Aug 2023 15:26:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqI299/RXQK9tDmaq2T8s5Q1uiUPqh6hJFsDvLp3lFVE25T0IuwfnsPffE/kcheXbtnMpqaA==
X-Received: by 2002:a05:620a:394e:b0:76c:fb54:93a3 with SMTP id
 qs14-20020a05620a394e00b0076cfb5493a3mr238871qkn.2.1692138360432; 
 Tue, 15 Aug 2023 15:26:00 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 b14-20020a05620a118e00b00768283dcb63sm4024953qkk.123.2023.08.15.15.25.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 15:26:00 -0700 (PDT)
Date: Tue, 15 Aug 2023 18:25:58 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH 3/5] migration/ram: Move xbzrle zero page handling into
 save_zero_page
Message-ID: <ZNv7dlV9P+Njvw+y@x1n>
References: <20230815143828.15436-1-farosas@suse.de>
 <20230815143828.15436-4-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230815143828.15436-4-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.04,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Aug 15, 2023 at 11:38:26AM -0300, Fabiano Rosas wrote:
> It makes a bit more sense to have the zero page handling of xbzrle
> right where we save the zero page.
> 
> This also makes save_zero_page() follow the same format as
> save_compress_page() at the top level of
> ram_save_target_page_legacy().
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


