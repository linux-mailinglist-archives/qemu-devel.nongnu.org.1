Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 74202B01E53
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Jul 2025 15:51:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaEAE-0007z7-QI; Fri, 11 Jul 2025 09:51:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1uaE5r-00072r-RG
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:47:25 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1uaE5n-0001I4-Uz
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:47:15 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1752241617; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=QTL9QG1hz10/Ll1gw6kN+mYmaMCkNpb0sN4dIAOKc4Ce/5I9mZAqPtqm3atrqSwqN6hfgFqyPlup1SLwXii1RaNy7m5nudOmCnhEOcZINtczM1G5x5DgH1ddcswh6hs4HIrwvSN2lxs1DbtpTOC4Vw8Q9Vfy9h6DF8B/A4hSM7Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1752241617;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=qC9lcAe/N0snu9XeaLcjFkrhTbtIi+exs79KrIbW7W8=; 
 b=NW7k4tFx6GE497CHd4K7B1Hjhp95cUSKfdZAe5QtqodtqCeTMmRH2m+iHIpK4y3vpv3LrMDayzogx96FvuZVy1KUnm6hZc12R3o+gW8dVSyHuXkH2GuKXCT9Ba8nzS1dy63jvYPRoOYFmLtBs3l2E17xxxqk7qFnhrOgIZ4RLuU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752241617; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=qC9lcAe/N0snu9XeaLcjFkrhTbtIi+exs79KrIbW7W8=;
 b=V6dVZvPCi+8+e80Nk9uGVr/dS7FU51MFjiaSNKlp+w2vUhwUTBHHdwHbFesoEUer
 XeyvqfZFkJzMt5ITtAWzR9QlKaHhjPjkcIsXqet/iwRmT5qCVdoxYU8plFJYQpEQerY
 nW4ikKwXDD6PZYHY265PUn/1boZ3y/xk/FqoJTF0=
Received: by mx.zohomail.com with SMTPS id 175224161506458.50159822795263;
 Fri, 11 Jul 2025 06:46:55 -0700 (PDT)
Message-ID: <8f8eae1b-4a43-45ed-b748-66a364b1cc8d@collabora.com>
Date: Fri, 11 Jul 2025 16:46:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/7] ui/spice: Create a new texture with linear layout
 when gl=on is specified
To: Vivek Kasireddy <vivek.kasireddy@intel.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Frediano Ziglio <freddy77@gmail.com>, Dongwon Kim <dongwon.kim@intel.com>,
 Michael Scherle <michael.scherle@rz.uni-freiburg.de>
References: <20250617043546.1022779-1-vivek.kasireddy@intel.com>
 <20250617043546.1022779-7-vivek.kasireddy@intel.com>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <20250617043546.1022779-7-vivek.kasireddy@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 6/17/25 07:32, Vivek Kasireddy wrote:
> diff --git a/ui/console-gl.c b/ui/console-gl.c
> index afb36dba64..403fc36fbd 100644
> --- a/ui/console-gl.c
> +++ b/ui/console-gl.c
> @@ -184,6 +184,12 @@ void surface_gl_destroy_texture(QemuGLShader *gls,
>      }
>      glDeleteTextures(1, &surface->texture);
>      surface->texture = 0;
> +#ifdef GL_EXT_memory_object_fd
> +    if (surface->mem_obj) {
> +        glDeleteMemoryObjectsEXT(1, &surface->mem_obj);
> +        surface->mem_obj = 0;
> +    }

Nit: spec says that deleting surface->mem_obj=0 is ignored, hence the
"if (surface->mem_obj)" check shouldn't be needed, like in a case with
glDeleteTextures() above. That would make code look more consistent.

-- 
Best regards,
Dmitry

