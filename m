Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B577DD3A6
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 18:01:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxs6V-0005Sh-Iw; Tue, 31 Oct 2023 13:00:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxs6R-0005S6-TM
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 13:00:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxs6Q-0001Xp-4X
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 13:00:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698771628;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=7Fq54dt3iIUgK+MgeDVzRJntDRqxdmbOBtBBay8zMGQ=;
 b=GCEcXSdGUMLCGUoTJkKIjLtoGTacyWuce66Xvq/4IX1KFkb3S0b/+oIoH00TDUbxvch3ZW
 8n6DZCCCuAzkfg/dySYAFJ1gaduKT+pthUUUutNGHxBewepVD4NeFcsy6dns77p4YVITuT
 DakM+BgjaFI8Gp/wfDlkV2DHFgFGWws=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-JryPOv_ROYaHCgqPbwYr0w-1; Tue, 31 Oct 2023 13:00:14 -0400
X-MC-Unique: JryPOv_ROYaHCgqPbwYr0w-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2c53c85e482so61057241fa.1
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 10:00:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698771613; x=1699376413;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7Fq54dt3iIUgK+MgeDVzRJntDRqxdmbOBtBBay8zMGQ=;
 b=pMizbpy65drEHNUXghxCyNEDZBCJ4AQFP2gBNxLFcn9xMCShFkUFLMuHdMTbR42mqC
 7yKysIIJMB1tVFZzWDNLtkHSSUsW8zBBQSEMpTNs+wNhOMLPa9E4BPnWXXT9OLmBAXDb
 nkFSJrp6DByx1rM7lg3ux7/EjcCAxZl45xV8RKbqiaZMe8hLqu4RIuyhqfcorVdE8p/L
 /NoJ1qsk6GIDMfaY/p3vF5Qsv7egOYgSttrfVhuTYRjXrufh/gpw1KepNgFnBWNUctnU
 qko2CjDJVdQWuHja3YHfAh6HdC7lq/fKTatgTxI1xzuHtfygRO4HAgxrLPrkzvjqeMij
 TShg==
X-Gm-Message-State: AOJu0YyPE6u3w9y5L4TDVI8AgUjOOIUdd7TVtnURp7l5z6D9x/HwKHbG
 qOyu4MQNXHcKFe/hUCi/Mc7XFopKJMTxSsAhGK74AHxE08DOj7yXAVP4PLvgJnuatGM8gq9oiVa
 MTn9C6bx3MiOVO4o=
X-Received: by 2002:a2e:9598:0:b0:2c5:1073:5f2 with SMTP id
 w24-20020a2e9598000000b002c5107305f2mr9777584ljh.5.1698771613076; 
 Tue, 31 Oct 2023 10:00:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3n05YbfgPtR/EwkYYVzcap9bCMQ+aa1hyt/kyHEg9X45Vva9O0G3SWVAu3mcsTEiWJEvT0Q==
X-Received: by 2002:a2e:9598:0:b0:2c5:1073:5f2 with SMTP id
 w24-20020a2e9598000000b002c5107305f2mr9777557ljh.5.1698771612726; 
 Tue, 31 Oct 2023 10:00:12 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 r17-20020a5d4991000000b0032d9a1f2ec3sm1895421wrq.27.2023.10.31.10.00.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 10:00:11 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  prerna.saxena@nutanix.com,  dgilbert@redhat.com,
 pbonzini@redhat.com,  berrange@redhat.com,  armbru@redhat.com,
 eblake@redhat.com,  manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com,  Het Gala <het.gala@nutanix.com>,  Peter
 Xu <peterx@redhat.com>,  Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v15 08/14] migration: Convert the file backend to the
 new QAPI syntax
In-Reply-To: <20231023182053.8711-9-farosas@suse.de> (Fabiano Rosas's message
 of "Mon, 23 Oct 2023 15:20:47 -0300")
References: <20231023182053.8711-1-farosas@suse.de>
 <20231023182053.8711-9-farosas@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Tue, 31 Oct 2023 18:00:11 +0100
Message-ID: <87bkce682s.fsf@secure.mitica>
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

Fabiano Rosas <farosas@suse.de> wrote:
> Convert the file: URI to accept a FileMigrationArgs to be compatible
> with the new migration QAPI.
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Juan Quintela <quintela@redhat.com>


