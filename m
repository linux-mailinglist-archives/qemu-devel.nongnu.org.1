Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C400A737EF5
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 11:27:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBu6E-0004S4-Ti; Wed, 21 Jun 2023 05:26:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qBu6C-0004Re-Ct
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 05:26:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qBu6A-0001Vn-Ra
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 05:26:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687339557;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iy75wA7uQIx63kfFUQhvIpUV6h1Ez7BJjiBdC0bgtsY=;
 b=OqqMeGbufXJ0Fh0Rx5I76FsLyuxLjb/bkx/1OBc03MlWC2OHhyciWIgC3JEhu0hDWHgEqJ
 yjtXkDXlnmQF6mXMtvUunv/gFMXzEKLm9gM5NQIDV6NTuNGuldkdpfCGiPy5TOuwQlPxuO
 c9ncFHUL8yagrTsXHtnc5d0GP+s/tB4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-k8k7O8cbMx2i_tAg9q1xPQ-1; Wed, 21 Jun 2023 05:25:55 -0400
X-MC-Unique: k8k7O8cbMx2i_tAg9q1xPQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f96d10ebd8so19337125e9.0
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 02:25:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687339554; x=1689931554;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iy75wA7uQIx63kfFUQhvIpUV6h1Ez7BJjiBdC0bgtsY=;
 b=KuiOPckfBpnVHiDFsScR1GbS7cUxmPUkjvR56XGMeMotWpK4Lhy0XFxCqjx5BwYRpK
 huxufqrlM8geTvRTgrmDS8rHFUy6eyvoRbFwpMmA2Laqis8Sj38ZJyruF6F66cRps5d2
 KhHuNHy4QHjQDK7LY06Y+tgM4YYsnYGLhc2YJ7+K2Pl7nCZzPyp2CYmpDGKQYJlcRumz
 BaQyoCpIKCfTG+W52V4kE+YcqedVToMyHZDmrxITjzADayHqXC2opEZthkFSstbeFzs3
 3TSVpFdHFpa9HWPWrMsTrH32xLmeN0wjzQnarOgCyfpBgwbZbDxSgGPlaQmtAZsZLuQ/
 S2sw==
X-Gm-Message-State: AC+VfDwsnnGqRk7yyUBi/pyL7RmQCP5XZYpWZnPPybznesN6O2f8fj52
 WTW3EAl5Q+EKbVTYovBWfbwy1UewvfN42s34nmBdrrJQxaj0TNfBG/YDtWTzf01z0R8oiu6Wz9Z
 gkF4bAZp/g+E8n1U=
X-Received: by 2002:a7b:c017:0:b0:3f7:aad8:4e05 with SMTP id
 c23-20020a7bc017000000b003f7aad84e05mr11446852wmb.11.1687339554550; 
 Wed, 21 Jun 2023 02:25:54 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5thCFxyd/7WZdFbYTsN0Fr4A8ErwcKay3zYxRzDcLjYyYTBUczdg+jyRWKDSMsYuldZWAq4A==
X-Received: by 2002:a7b:c017:0:b0:3f7:aad8:4e05 with SMTP id
 c23-20020a7bc017000000b003f7aad84e05mr11446833wmb.11.1687339554230; 
 Wed, 21 Jun 2023 02:25:54 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 z5-20020a1c4c05000000b003f7cb42fa20sm4477118wmf.42.2023.06.21.02.25.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jun 2023 02:25:53 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: ~hyman <hyman@git.sr.ht>
Cc: qemu-devel <qemu-devel@nongnu.org>,  ~hyman <yong.huang@smartx.com>,
 Peter Xu <peterx@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  "Dr.
 David Alan Gilbert" <dgilbert@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Markus Armbruster <armbru@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Laurent Vivier <lvivier@redhat.com>,  Richard
 Henderson <richard.henderson@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Dau?=
 =?utf-8?Q?d=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH QEMU v6 6/9] migration: Put the detection logic before
 auto-converge checking
In-Reply-To: <168733225273.5845.15871826788879741674-6@git.sr.ht>
 (hyman@git.sr.ht's message of "Thu, 15 Jun 2023 21:29:44 +0800")
References: <168733225273.5845.15871826788879741674-6@git.sr.ht>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Wed, 21 Jun 2023 11:25:52 +0200
Message-ID: <87y1kdb1zz.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

~hyman <hyman@git.sr.ht> wrote:
> From: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.com>
>
> This commit is prepared for the implementation of dirty-limit
> convergence algo.
>
> The detection logic of throttling condition can apply to both
> auto-converge and dirty-limit algo, putting it's position
> before the checking logic for auto-converge feature.
>
> Signed-off-by: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

queued


