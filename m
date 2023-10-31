Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7767D7DCD98
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 14:18:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxocX-0001E4-AT; Tue, 31 Oct 2023 09:17:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxocW-0001Dt-3s
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 09:17:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxocU-0000kV-IR
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 09:17:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698758240;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=beC5BLJKM1nBI5lf8dQOEPojvyyVi7ui2FAWrkjKJ7g=;
 b=VVLW7hIo65Okfznar/VT8CXyWEVQpomw7ioIfFLC7+BvHJEAlp3ft4aNn0pVBHnQ5t8iAn
 kFSecTUnSRTOGKTAKUOk4ocVk04JQZ4n0MZA1SpiWo2v0cdZodqREVQ9Pp+D64vTbxZi4i
 Xfv6AIGdypmEHDm3JchkU372hcVk6ro=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-BPykqNriP5SjJVClwTRybQ-1; Tue, 31 Oct 2023 09:17:14 -0400
X-MC-Unique: BPykqNriP5SjJVClwTRybQ-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-507b9078aaaso6588154e87.2
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 06:17:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698758233; x=1699363033;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=beC5BLJKM1nBI5lf8dQOEPojvyyVi7ui2FAWrkjKJ7g=;
 b=uY7vveLMo5Wn9yTZ66vAAGjrb57jPgin81XfWVEUi3BdvMwii0W8ZGMHGizJMIEooe
 F+0aL8TtAlQ/k+r9t+l/bfFpCBLC+47aJ9vNsGeFVgVsqFu483L8nz5OuBN4FiZ0Cvgg
 SSqNyAz3OUHXx+DY87SYSasKXCl+zubh5YheU4e8tPwKSGAVmXY2Uv6FKPIuY/YymJJ0
 SZ6B1XmN8ngRxcGg2YGCB7D1F99fBLAlGYC6HIW4IOsnKDfuYpON5xvG3jOI1ddDerH9
 MUgx6z1DuOBE8ZGCU/eQp5WGIzu27evPU0JLDh43tVhxg9UelY5W5nY31rmP7j/h5S5L
 CV0A==
X-Gm-Message-State: AOJu0Yzq2fFcbQOMopkyBK8KRKi/WFrxYUWSCdfMXDYTiuVsYfNgxi7Z
 WJEX46kQWq82Efr/ndrcZvyEIoutbdgMXBvJJXETsYO3TEcn+3E1d7jd30k2IqhFj9CwVxz07Gp
 HJfLhnGqey9fPvZU=
X-Received: by 2002:a05:6512:3b97:b0:507:9777:a34a with SMTP id
 g23-20020a0565123b9700b005079777a34amr13109999lfv.39.1698758233040; 
 Tue, 31 Oct 2023 06:17:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjzC+GVbXWMzOb1SfaSNVvEXACukP1HirACvndl1Un2Y40exM+cJTCnMSt5C4JghTJJ5I1ng==
X-Received: by 2002:a05:6512:3b97:b0:507:9777:a34a with SMTP id
 g23-20020a0565123b9700b005079777a34amr13109981lfv.39.1698758232717; 
 Tue, 31 Oct 2023 06:17:12 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 p15-20020a05600c468f00b0040472ad9a3dsm1728861wmo.14.2023.10.31.06.17.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 06:17:11 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,  Leonardo Bras <leobras@redhat.com>,  "Daniel P.
 Berrange" <berrange@redhat.com>
Subject: Re: [PATCH V2 1/6] migration: mode parameter
In-Reply-To: <1698263069-406971-2-git-send-email-steven.sistare@oracle.com>
 (Steve Sistare's message of "Wed, 25 Oct 2023 12:44:24 -0700")
References: <1698263069-406971-1-git-send-email-steven.sistare@oracle.com>
 <1698263069-406971-2-git-send-email-steven.sistare@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Tue, 31 Oct 2023 14:17:11 +0100
Message-ID: <8734xr7wyw.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Steve Sistare <steven.sistare@oracle.com> wrote:
> Create a mode migration parameter that can be used to select alternate
> migration algorithms.  The default mode is normal, representing the
> current migration algorithm, and does not need to be explicitly set.
>
> No functional change until a new mode is added, except that the mode is
> shown by the 'info migrate' command.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

As nobody complained for this on v1, I will consider it done.


