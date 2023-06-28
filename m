Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B2C74172E
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 19:28:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEYwR-0001bX-Hk; Wed, 28 Jun 2023 13:26:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qEYwQ-0001bP-34
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 13:26:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qEYwO-0004sU-KE
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 13:26:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687973211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FuIKCMMdD1E5IlSd7tmfgvwoHDNnGtPNNLBURro6xE0=;
 b=FX8mL790v2zekAK+WxSL9tGxajhslm6WmYUZZyL85vkHCMkIt1vrG5WCBbnIsB2V+tMrSy
 yrjQNFYd504VogBB3KRf8MkR7y/A3w6nzYKVUB7+uTIv6da4HRhIunGe7lLSXyvmsMwQls
 j5BIUAXnqOovB0nvvlLRB/I8MIDPxL8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-fnRat6UaO1GY6obFxMfG_w-1; Wed, 28 Jun 2023 13:26:49 -0400
X-MC-Unique: fnRat6UaO1GY6obFxMfG_w-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7655fffd637so128612285a.1
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 10:26:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687973209; x=1690565209;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FuIKCMMdD1E5IlSd7tmfgvwoHDNnGtPNNLBURro6xE0=;
 b=aovzJip3psRvAopLYKrbqL3bbTqM+MdPq6h9VF1fvW2GYg2dZFl2FiyB5m4C2G4lAL
 TNkn5GLbT0XzeMK9JjgiuXvE2Qe+mSdxE0J/ST8mUjJmDvTAuWqPdTt+2T82ujJ4C6ck
 yTfttGL05+TH+OOcX5Y9b+wyKv8L1C9CuH0MQqTXBN1p9mly9VpZgDvTttI4DBBhHJ3i
 dSHumCxnzcdAS5pi+xeycb+bBQs+wZHh///rMe+6Qy8Nl+iiocq1cGvRJO5b3e1JtW2H
 AFjy2Y2+s5i4qpD7O1dKELohFmsQdZHRmD2/ezO5N6I3QL6C06+wXQf2DaGUDvWT4TPq
 NnaQ==
X-Gm-Message-State: AC+VfDxXmkq2oLo/Eko3iXZYvbTbrsBhIQlMyEnkeak/1cwjF6SXiJ7d
 fLEukMuLJ/3tDMDwRpONbh5SBn0LXiKQj282zERFWnNxOSBkGXU5loD2Z87BRdQbcJKHfKjM1N/
 r9+fJjaMPN9ZHM78=
X-Received: by 2002:a05:620a:190e:b0:767:1a23:137 with SMTP id
 bj14-20020a05620a190e00b007671a230137mr4690215qkb.2.1687973209387; 
 Wed, 28 Jun 2023 10:26:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5t6AFCq0jYctnvzaJr/iuucbMVm47Vk+AhEfYJPo32tdWmP2FaTrPwgkIX22xSJ1nZRnaD4g==
X-Received: by 2002:a05:620a:190e:b0:767:1a23:137 with SMTP id
 bj14-20020a05620a190e00b007671a230137mr4690200qkb.2.1687973209167; 
 Wed, 28 Jun 2023 10:26:49 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 y24-20020a37e318000000b007579ea33cdesm5226905qki.62.2023.06.28.10.26.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jun 2023 10:26:48 -0700 (PDT)
Date: Wed, 28 Jun 2023 13:26:48 -0400
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH V3 2/2] migration: file URI offset
Message-ID: <ZJxtWAKXaPQa/YBJ@x1n>
References: <1687466251-310524-1-git-send-email-steven.sistare@oracle.com>
 <1687466251-310524-3-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1687466251-310524-3-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jun 22, 2023 at 01:37:31PM -0700, Steve Sistare wrote:
> Allow an offset option to be specified as part of the file URI, in
> the form "file:filename,offset=offset", where offset accepts the common
> size suffixes, or the 0x prefix, but not both.  Migration data is written
> to and read from the file starting at offset.  If unspecified, it defaults
> to 0.
> 
> This is needed by libvirt to store its own data at the head of the file.
> 
> Suggested-by: Daniel P. Berrange <berrange@redhat.com>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Ideally I think we should make "," the separator from the start, but I
suppose no one will try to apply previous patch only, and then start using
a file name contains ",offset=".. so maybe not that a huge deal.

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


