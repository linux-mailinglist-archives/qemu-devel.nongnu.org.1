Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F33FE82B29E
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 17:17:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNxj0-0006dN-Mj; Thu, 11 Jan 2024 11:16:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>) id 1rNxix-0006dC-RT
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 11:16:07 -0500
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>) id 1rNxiv-0005DQ-3R
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 11:16:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Type:MIME-Version:Message-ID:Date:References:
 In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HnQTwr8FpFLs70+WZDayxp1ofDClSs99BD6ULbJmUJM=; b=UY6R3b9IWjqHhLUp8TuCogBWKm
 dqT42CjtMgxYQfit76hp2UKx2BeCFs8IZ2llQXXtQ48bS0ZxF5sVPvZY4mluiNIuDI419gXlwcYum
 9nCQ0U0cFNyDQXdYZNw4b1PA/y3OddP4gtTTK+LJjYbcjCvDkYgFEKnZ4eped8tbOGii/wvnIpWMj
 uezpruIj3PVRKumbxy8FXDVJ3Z8vW3GWf54YubITR7/a/IA3PupRMGQwpsWrHQG1lQUfs0cz/lSyd
 +bfPaMVQCVH8TOL6bEMm/8Iz2V2UwMQ6hU2pxxbLEwQaPlSJSPQTa0UtYF0rf6HDOcTUrrxmCdQDx
 cQsI1qeQ==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine2.igalia.com with esmtps 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1rNxiY-005SAe-FL; Thu, 11 Jan 2024 17:15:42 +0100
Received: from gate.service.igalia.com ([192.168.21.52])
 by mail.igalia.com with esmtp (Exim)
 id 1rNxiW-00Fq29-4B; Thu, 11 Jan 2024 17:15:42 +0100
Received: from berto by gate.service.igalia.com with local (Exim 4.96)
 (envelope-from <berto@igalia.com>) id 1rNxiV-009lN5-34;
 Thu, 11 Jan 2024 16:15:39 +0000
From: Alberto Garcia <berto@igalia.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?Q?Daniel_P_=2E_Berrang?=
 =?utf-8?Q?=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, Eric Blake
 <eblake@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH for-9.0] qapi: Add 'recurse-children' option to qom-list
In-Reply-To: <878r5mv89b.fsf@pond.sub.org>
References: <20231124162443.124654-1-berto@igalia.com>
 <878r5mv89b.fsf@pond.sub.org>
Date: Thu, 11 Jan 2024 16:15:39 +0000
Message-ID: <w51le8vq21g.fsf@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine2.igalia.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri 22 Dec 2023 11:31:12 AM +01, Markus Armbruster wrote:
>> This allows returning a tree of all object properties under a given
>> path, in a way similar to scripts/qmp/qom-tree.
>
> Use case?  We already have that script, and also HMP info qom-tree.

The main use case is convenience.

Management tools need to manually check that the type starts with
"child<" and recursively make a new QMP call. That's what e.g libvirt
does:

   https://gitlab.com/libvirt/libvirt/-/blob/v9.10.0/src/qemu/qemu_monitor_json.c?ref_type=tags#L7367

Parsing the output of HMP info qom-tree is not an option in that case.

Berto

