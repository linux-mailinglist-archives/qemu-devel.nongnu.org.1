Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F6B80EF9C
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 16:06:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD4Jq-00064b-3n; Tue, 12 Dec 2023 10:05:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rD4Jn-00064M-A7
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 10:05:07 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rD4Jl-000327-1l
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 10:05:07 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-548ce39b101so8183871a12.2
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 07:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702393499; x=1702998299; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KyO8UEeQ7SUyGrlIUzp4SC78cjP3zY61TcTVqhdqEnU=;
 b=VFq6Y9AsW684BglQSDu1f3LuXlgwGkxxnLUurD4vH6wGt1t7/CA/GIOmOlogtVQMOM
 4HtN5zwwB94Yw1RJefB/reyLPXIXVyGaVkxlp7SUmC8Ne/1PlxQ5UeWwP4hMPCNDUDws
 VK4v+obg1LOPvRfGOlEvy++Mv3RD3YP2FgkXaqHE5/+qTOo9fIFjQHhu+q3tQfAW0hhz
 3gzsiHer3nhPw1EFGzOa4oi3iGMz8lsueybb1mbvuf3zPm94QjFiELrPtFku5UTg6jEF
 orUL4wkgEdjALGvn7qSVCMRuXhxg7Gwlep/VO4eW7x96wgJCHjmeZiEG4vIio0lmUocu
 uM+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702393499; x=1702998299;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KyO8UEeQ7SUyGrlIUzp4SC78cjP3zY61TcTVqhdqEnU=;
 b=CkIJiCdT9Mr9LGD6ISwKcah7vUUM9y7WmZtWQIJ0BpjyK6NJKqi7srIimUCxtDWmW/
 3o+wpwrb+v8+tiEh4P/66QpOT+AL4Rc/2VctEfIFrhxgQP70spg+Bihjq8qWjmVEbfVe
 58Cfzti/nUsCu5b6qqUEd56X1jEdB4M6pP8OxvYsXBOPr6q3k21HIgniv3CJxaDgSrGn
 b1AyzH4QlGaDIwsx6pG7/7GwOlURY7RdmRzYFdjVXmonfHBxWOipDnot00GXOMJ34/C6
 gDaOB/0rGZT5FYv6j8sOAhBgD5+iZZ+KFvDJ6m+nCYLBpypS5oVZ1sFzzXjw5V3dOOwy
 7orA==
X-Gm-Message-State: AOJu0YzMP/UvlQ/8a/rdKS0L3baZkfTKhdy23i/WlU64F2rkvyHOrUjj
 BbrQM9rUYRszq/XjC5/51nc8xR9bvnQdZjhXkH70mg==
X-Google-Smtp-Source: AGHT+IHY/0t0+50ic628E7AUgCGoyo3dNCmUNohxWoZzOyU6UgFofjl+Ki7RmM2dERNqtds8uLY6t18VAKnrKCcRH+w=
X-Received: by 2002:a50:d652:0:b0:551:d98c:1450 with SMTP id
 c18-20020a50d652000000b00551d98c1450mr95838edj.77.1702393499195; Tue, 12 Dec
 2023 07:04:59 -0800 (PST)
MIME-Version: 1.0
References: <7a25bd4ee1f8b06c7a51d20486aaa8bc8e1282ea.camel@amazon.co.uk>
In-Reply-To: <7a25bd4ee1f8b06c7a51d20486aaa8bc8e1282ea.camel@amazon.co.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Dec 2023 15:04:48 +0000
Message-ID: <CAFEAcA-LTRnJqVcu=4VpgqjBeoi_ugGRrYOnajCzn49r3ijacw@mail.gmail.com>
Subject: Re: [PATCH] doc/sphinx/hxtool.py: add optional label argument to SRST
 directive
To: "Woodhouse, David" <dwmw@amazon.co.uk>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, 9 Nov 2023 at 10:33, Woodhouse, David <dwmw@amazon.co.uk> wrote:
>
> We can't just embed labels directly into files like qemu-options.hx which
> are included from multiple top-level RST files, because Sphinx sees the
> labels as duplicate: https://github.com/sphinx-doc/sphinx/issues/9707
>
> So add an 'emitrefs' option to the Sphinx hxtool-doc directive, which is
> set only in invocation.rst and not from the HTML rendition of the man
> page. Along with an argument to the SRST directive which causes a label
> of the form '.. _LABEL-reference-label:' to be emitted when the emitrefs
> option is set.
>
> Now where the Xen PV documentation refers to the documentation for the
> -initrd command line option, it can emit a link directly to it.
>
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> Reviewed-by: Paul Durrant <paul@xen.org>

Thanks for splitting out this patch, and sorry I didn't get to
reviewing it earlier. The general idea is great, and I have
a few suggested tweaks below.

Something is weird about how you're sending out patchmails,
by the way: the patch appears in lore.kernel.org and in patchew,
but when patchew tries to apply it, or when I do locally, git complains
that it's empty:
https://patchew.org/QEMU/7a25bd4ee1f8b06c7a51d20486aaa8bc8e1282ea.camel@amazon.co.uk/

I think this is probably because the patch is a lot of
base-64-encoded multipart/mime. Sending it as good old
fashioned plain text will likely work better.

> ---
> https://qemu-project.gitlab.io/qemu/system/i386/xen.html tells the user
> to "see the command line documentation for the -initrd option". It'd be
> a whole lot nicer if we could *link* to it. It actually worked on my
> test box, but only because I'm using an older version of Sphinx which
> didn't complain about the duplicate refs, and just picked *one* to link
> to.
>
>  docs/sphinx/hxtool.py      | 18 +++++++++++++++++-
>  docs/system/i386/xen.rst   |  2 +-
>  docs/system/invocation.rst |  1 +
>  qemu-options.hx            |  2 +-
>  4 files changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/docs/sphinx/hxtool.py b/docs/sphinx/hxtool.py
> index 9f6b9d87dc..bfb0929573 100644
> --- a/docs/sphinx/hxtool.py
> +++ b/docs/sphinx/hxtool.py
> @@ -78,18 +78,28 @@ def parse_archheading(file, lnum, line):
>          serror(file, lnum, "Invalid ARCHHEADING line")
>      return match.group(1)
>
> +def parse_srst(file, lnum, line):
> +    """Handle an SRST directive"""
> +    # The input should be "SRST(label)".
> +    match = re.match(r'SRST\((.*?)\)', line)
> +    if match is None:
> +        serror(file, lnum, "Invalid SRST line")
> +    return match.group(1)
> +
>  class HxtoolDocDirective(Directive):
>      """Extract rST fragments from the specified .hx file"""
>      required_argument = 1
>      optional_arguments = 1
>      option_spec = {
> -        'hxfile': directives.unchanged_required
> +        'hxfile': directives.unchanged_required,
> +        'emitrefs': directives.flag
>      }
>      has_content = False
>
>      def run(self):
>          env = self.state.document.settings.env
>          hxfile = env.config.hxtool_srctree + '/' + self.arguments[0]
> +        emitrefs = "emitrefs" in self.options
>
>          # Tell sphinx of the dependency
>          env.note_dependency(os.path.abspath(hxfile))
> @@ -113,6 +123,12 @@ def run(self):
>                          serror(hxfile, lnum, 'expected ERST, found SRST')
>                      else:
>                          state = HxState.RST
> +                        if emitrefs and line != "SRST":
> +                            label = parse_srst(hxfile, lnum, line)

I think that rather than only calling parse_srst() under this
if(), we should do it always, and have parse_srst() accept
"SRST" alone as valid (meaning empty label, same as "SRST()").
Then we can append to the rstlist 'if emitrefs and label != ""'.

> +                            if label != "":
> +                                rstlist.append("", hxfile, lnum - 1)
> +                                refline = ".. _" + label + "-reference-label:"
> +                                rstlist.append(refline, hxfile, lnum - 1)
>                  elif directive == 'ERST':
>                      if state == HxState.CTEXT:
>                          serror(hxfile, lnum, 'expected SRST, found ERST')
> diff --git a/docs/system/i386/xen.rst b/docs/system/i386/xen.rst
> index 81898768ba..536dd6a2f9 100644
> --- a/docs/system/i386/xen.rst
> +++ b/docs/system/i386/xen.rst
> @@ -132,7 +132,7 @@ The example above provides the guest kernel command line after a separator
>  (" ``--`` ") on the Xen command line, and does not provide the guest kernel
>  with an actual initramfs, which would need to listed as a second multiboot
>  module. For more complicated alternatives, see the command line
> -documentation for the ``-initrd`` option.
> +:ref:`documentation <initrd-reference-label>` for the ``-initrd`` option.

I think we should include the hxfile basename in the label name
we generate. We also don't need to say "label", it's implicitly a
label. Then when we refer to things we can say
   <qemu-options-initrd>
   <hmp-commands-screendump>

and it's fairly readable what we're referring back to.

(We could alternatively have the emitrefs option take an argument
for what to use in label names. I don't have a strong view on
which would be better.)

>
>  Host OS requirements
>  --------------------
> diff --git a/docs/system/invocation.rst b/docs/system/invocation.rst
> index 4ba38fc23d..ef75dad2e2 100644
> --- a/docs/system/invocation.rst
> +++ b/docs/system/invocation.rst
> @@ -11,6 +11,7 @@ disk_image is a raw hard disk image for IDE hard disk 0. Some targets do
>  not need a disk image.
>
>  .. hxtool-doc:: qemu-options.hx
> +    :emitrefs:
>
>  Device URL Syntax
>  ~~~~~~~~~~~~~~~~~
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 42fd09e4de..464e7257b0 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -3987,7 +3987,7 @@ ERST
>
>  DEF("initrd", HAS_ARG, QEMU_OPTION_initrd, \
>             "-initrd file    use 'file' as initial ram disk\n", QEMU_ARCH_ALL)
> -SRST
> +SRST(initrd)
>
>  ``-initrd file``
>      Use file as initial ram disk.
> --
> 2.34.1

We really need to document the .hx file syntax (currently this is
only in comments at the top of individual .hx files). I'll
put together a quick patch that does that, which will give us
somewhere to add the information about how label-generation
works in this patch.

thanks
-- PMM

