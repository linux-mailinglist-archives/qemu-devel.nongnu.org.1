Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 773A17C51EA
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 13:23:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqXJC-0001Nw-Nu; Wed, 11 Oct 2023 07:23:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqXJ6-00016r-Bs
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 07:23:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqXIn-00017R-Kx
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 07:23:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697023368;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=qVqumvq4e17FJeZZ6pgBw0L/Wd03xt8bRiZ4HuMxHVk=;
 b=Mqn8rpayDOZqVpqok6uqPpm0I6JTURIiy18gRUHfqaC5wsytHAfP9IhW7smqak8OMuydW1
 h47JKuC1NagPTrLRu9ZRjxo1jQ78+tOisWz7mWNY34/rCUqiBpSDVguijxu1OZa0kqTF7t
 88uICvE+CZNyX5cQ6YLIc2z/Y7YQDX4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-_m_cH6wROeKNj9lu5Qw7dQ-1; Wed, 11 Oct 2023 07:22:47 -0400
X-MC-Unique: _m_cH6wROeKNj9lu5Qw7dQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4074f9d17a5so19023775e9.1
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 04:22:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697023366; x=1697628166;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qVqumvq4e17FJeZZ6pgBw0L/Wd03xt8bRiZ4HuMxHVk=;
 b=ZQvpMX7Jqf/Hnf8ahjZSuUv3e2S3x8lmvwu1oXuraiE7KUU2RtZwGk62HjXpJza/pD
 hvgavsvpN6ahdbLYybliMX6LNNcgfPoIP7enqYk87SEy3I/hMzdZ/x6S9gL6MF5XFZhb
 EnDh7/Rbwix5UzokT4YeBHFA/EVuvz6ZiTT90aK/TXYxGutI/vMKRBoMi9SjoWpd9zNY
 QP/CS6paTNy8bjOkVjKVi/s9aT6pUa/uLqzRgbUPumgftlBv5IcrSUeNapRWicOke+hT
 2s7NFwFH2YeLNJi5VxVXkxJCdQQXQhZWYz9/vM8wGJiqCu8hoMWoqLgb4AilGmvC3zDx
 jGog==
X-Gm-Message-State: AOJu0Yz/i7jyc9ekQroU7A/CwEpISFx1X9Ozj2ah7tvhEgglnBnqf2ow
 apUXy6wA3xMk80GOMq1qqoDgAH9a9XBFxHMgDhXsjbsoHNVWeAHS2ufnKTSLyKi0ObFLi8ByT1D
 XPpeY6elYadY7Th4=
X-Received: by 2002:a7b:c84d:0:b0:401:b504:b6a0 with SMTP id
 c13-20020a7bc84d000000b00401b504b6a0mr17580207wml.3.1697023366411; 
 Wed, 11 Oct 2023 04:22:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBGXchgFw2bRpeAGndsncWcG3OcpFaW2yt9p/lWeYjwYOAj2SnupdTwagf5ThjCtITvTkOpg==
X-Received: by 2002:a7b:c84d:0:b0:401:b504:b6a0 with SMTP id
 c13-20020a7bc84d000000b00401b504b6a0mr17580184wml.3.1697023365896; 
 Wed, 11 Oct 2023 04:22:45 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 p7-20020a1c7407000000b003fd2d3462fcsm281239wmc.1.2023.10.11.04.22.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 04:22:45 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Wei Wang <wei.w.wang@intel.com>
Cc: peterx@redhat.com,  isaku.yamahata@gmail.com,  qemu-devel@nongnu.org
Subject: Re: [PATCH v2] migration: refactor migration_completion
In-Reply-To: <20230804093053.5037-1-wei.w.wang@intel.com> (Wei Wang's message
 of "Fri, 4 Aug 2023 17:30:53 +0800")
References: <20230804093053.5037-1-wei.w.wang@intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 11 Oct 2023 13:22:44 +0200
Message-ID: <87zg0pbdyz.fsf@secure.mitica>
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
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Wei Wang <wei.w.wang@intel.com> wrote:
> Current migration_completion function is a bit long. Refactor the long
> implementation into different subfunctions:
> - migration_completion_precopy: completion code related to precopy
> - migration_completion_postcopy: completion code related to postcopy
> - close_return_path_on_source: rp thread related cleanup on migration
> completion. It is named to match with open_return_path_on_source.
>
> This improves readability and is easier for future updates (e.g. add new
> subfunctions when completion code related to new features are needed). No
> functional changes intended.
>
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

queued.


