Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E780AA43639
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Feb 2025 08:36:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmpTS-0005LG-1B; Tue, 25 Feb 2025 02:35:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tmpTL-0005L2-IB; Tue, 25 Feb 2025 02:35:19 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tmpTI-0008A2-Hx; Tue, 25 Feb 2025 02:35:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740468916; x=1772004916;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=9UcNm/2AsIzjiSh9HbKpj3tAVTyICGbHu7tIHJWApOI=;
 b=jb2XtFHmIPuwRBFqTQJw0y1ytVmUHhJgqyIQmNmgrXxXksljRzww3Etl
 8tFSaeDoLrJ96VIwFEtaJBVTdlSa+AJ+Jgqpq4jru6D1178Cga572f73d
 TLYYgEBLG5Xv6QXBDmWMacZVaFmhJC7nvRnJ4NC4W/9RXFjTeTI2OLA+D
 CRgrxRsAc2+IRIDKzLBpFLysQMAIFL0XTu2+Q38LTT8WVWy7QcCyX9ksb
 bIuzBB/Js2Kvaaz/RBXj5VfiDKghNyQWfbodx54pWaBMUxztHI0eRZlaL
 /gLhaRKAsqdYXTBkLYM+/BJbqSocOG/IK83j+YTP3Cv5fRuT+GTBxcD+g g==;
X-CSE-ConnectionGUID: ZO8IXsFiSzy1tYptCa6jYA==
X-CSE-MsgGUID: cJYdNfQ/ThS5B5zgVcbBlw==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="51475884"
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; d="scan'208";a="51475884"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2025 23:35:10 -0800
X-CSE-ConnectionGUID: /DaOjb18RpqyBVckUQ2tkw==
X-CSE-MsgGUID: Ma+TUmPHQImsAERxwGaLsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; d="scan'208";a="116292587"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa006.jf.intel.com with ESMTP; 24 Feb 2025 23:35:09 -0800
Date: Tue, 25 Feb 2025 15:54:46 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 07/15] rust: qemu_api_macros: add Wrapper derive macro
Message-ID: <Z713RoTrhiRWxoOJ@intel.com>
References: <20250221170342.63591-1-pbonzini@redhat.com>
 <20250221170342.63591-8-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221170342.63591-8-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> +fn derive_opaque_or_error(input: DeriveInput) -> Result<proc_macro2::TokenStream, MacroError> {
> +    is_transparent_repr(&input, "#[derive(Wrapper)]")?;
> +
> +    let name = &input.ident;
> +    let field = &get_unnamed_field(&input, "#[derive(Wrapper)]")?;
> +    let typ = &field.ty;
> +
> +    // TODO: how to add "::qemu_api"?  For now, this is only used in the
> +    // qemu_api crate so it's not a problem.
> +    Ok(quote! {
> +        unsafe impl crate::cell::Wrapper for #name {
> +            type Wrapped = <#typ as crate::cell::Wrapper>::Wrapped;
> +        }
> +        impl #name {
> +            pub unsafe fn from_raw<'a>(ptr: *mut <Self as crate::cell::Wrapper>::Wrapped) -> &'a Self {
> +                let ptr = ::std::ptr::NonNull::new(ptr).unwrap().cast::<Self>();
> +                unsafe { ptr.as_ref() }
> +            }
> +
> +            pub const fn as_mut_ptr(&self) -> *mut <Self as crate::cell::Wrapper>::Wrapped {
> +                self.0.as_mut_ptr()
> +            }
> +
> +            pub const fn as_ptr(&self) -> *const <Self as crate::cell::Wrapper>::Wrapped {
> +                self.0.as_ptr()
> +            }

What about also adding as_void_ptr? Then DeviceState can benefit from
this in qdev_init_clock_in.

> +        }
> +    })
> +}
> +

Others are fine for me. Nice improvement!

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


