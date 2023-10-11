Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF557C551A
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 15:18:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqZ5T-0002iF-67; Wed, 11 Oct 2023 09:17:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqZ5O-0002hp-AR
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 09:17:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqZ5L-0002yN-Bm
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 09:17:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697030230;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=FGdKbSPBI8Qdbl17BSzMnM74LeJPIAAFQGqRS9P0XA0=;
 b=DojC8+BdqyAsVTSTedcm6J3EST075lWhMHhfT7FwpTiP4s6goiHFGW+oco2+IL3dr4uP09
 QeCk5ufXdvip6H0fSEaIkgeZcxj8TyWm4kVkVnkr61kW5giesdH+2/6dDiP05HkcLiGqyC
 fBP26Wgi4yaZtog186kAIYlTY6p1vPs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-hl8b4_ILOHK2qjPl993aqg-1; Wed, 11 Oct 2023 09:16:54 -0400
X-MC-Unique: hl8b4_ILOHK2qjPl993aqg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-326f05ed8f9so4892419f8f.0
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 06:16:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697030212; x=1697635012;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FGdKbSPBI8Qdbl17BSzMnM74LeJPIAAFQGqRS9P0XA0=;
 b=crIHUTG31be8RmpMMPKRiRQxg+G+nr+Qtj3OgRDX4G3dFnj8QMvT0rKgKybuI1MwLq
 qiifVfrA2rkqvr8HYrzFXSG8Zk7RQCwi+8oY1wNpW8vHkCKo/T/3JzbzITabWUspHUYH
 bnP8oz2pXi69XBL6rH1J4i2DKJbsRdXYqvUY6M3MAD3Mi3wp1TeCbHOQP361fNDnjJip
 lTdl6pc6VPjDS8Sxg3lZAxogLjKesKSdaPBo88WFvLUt89DXW7LcUKC155dBujW09X8V
 mTsWWi0LnVlsdgAj1KuM6ER6kpYHUAcmJrDSKqeecnPeWjqFu3Nfg3JHzZgOF7+zDxPA
 wW2w==
X-Gm-Message-State: AOJu0Yw65GfIHCGthjSgpM9cPCfjNxVdNzs015JKsx1bH7XXvB7wCJPK
 1ahSqDn0Xv+L0bOoItAQjEjO5rzghH21WctBcD8gDQz8HEo1799G8jWAJrRfQWqV7CYUgCROTrK
 KH6/cCb/9QM4o0yxkXDndU56wZA==
X-Received: by 2002:adf:b357:0:b0:32d:82d8:3442 with SMTP id
 k23-20020adfb357000000b0032d82d83442mr2026758wrd.53.1697030212603; 
 Wed, 11 Oct 2023 06:16:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkUlBEpZvEbPMwPAnlCG2J5SRlzZto2T4NkoT7QUb+18tbMjD6RN/IdrSwBb4ksiMnzLJdCw==
X-Received: by 2002:adf:b357:0:b0:32d:82d8:3442 with SMTP id
 k23-20020adfb357000000b0032d82d83442mr2026730wrd.53.1697030211982; 
 Wed, 11 Oct 2023 06:16:51 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 e2-20020adfe382000000b00327de0173f6sm15469991wrm.115.2023.10.11.06.16.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 06:16:51 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,  John Snow <jsnow@redhat.com>,  Cleber
 Rosa <crosa@redhat.com>
Subject: Re: [PATCH v2 2/6] migration: Fix analyze-migration.py
 'configuration' parsing
In-Reply-To: <20231009184326.15777-3-farosas@suse.de> (Fabiano Rosas's message
 of "Mon, 9 Oct 2023 15:43:22 -0300")
References: <20231009184326.15777-1-farosas@suse.de>
 <20231009184326.15777-3-farosas@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 11 Oct 2023 15:16:50 +0200
Message-ID: <87a5spb8ot.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Fabiano Rosas <farosas@suse.de> wrote:
> The 'configuration' state subsections are currently not being parsed
> and the script fails when analyzing an aarch64 stream:
>
> Traceback (most recent call last):
>   File "./scripts/analyze-migration.py", line 625, in <module>
>     dump.read(dump_memory = args.memory)
>   File "./scripts/analyze-migration.py", line 571, in read
>     raise Exception("Unknown section type: %d" % section_type)
> Exception: Unknown section type: 5
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Juan Quintela <quintela@redhat.com>


