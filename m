Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E58EA21929
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Jan 2025 09:38:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1td3Zf-0002yH-Lj; Wed, 29 Jan 2025 03:37:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1td3Zd-0002xi-7N
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 03:37:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1td3Za-0006XL-8C
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 03:37:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738139841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=bZTrF9yuaTq6NNvHAR1cfIy3oKNzL8eR3Mt6kh0LLss=;
 b=IJkboSnT+PwpTvKUGfuph9FOc8RllAuZMa/RgND+qvR+yFtQH9LcBltKEIX9bsZKzGAQvO
 I/QIHInxzPV0TGWza/txE1wsOYDMa8iRw4RDq3AdmPuQyRfJEpDms8u01cf1Fa2AElFDQe
 6ZbCSwU5LSAi7HKFolIZAncFSjLGdj4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-84-sYwJkPICLwveO8DOWAQ-1; Wed, 29 Jan 2025 03:37:19 -0500
X-MC-Unique: 84-sYwJkPICLwveO8DOWAQ-1
X-Mimecast-MFC-AGG-ID: 84-sYwJkPICLwveO8DOWAQ
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-436289a570eso50456845e9.0
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2025 00:37:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738139837; x=1738744637;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bZTrF9yuaTq6NNvHAR1cfIy3oKNzL8eR3Mt6kh0LLss=;
 b=u21KCmjKoKESqcsurq64GXijtNDu10vt+SlRd9M4sTlpXf5EORDHX80wALOGQCTHx4
 Tf0Hn+MJ1v3E0PNoydO9yKCT62tcl3svVPGKUcesuEgywtkYLGskJeHGA2ottzPFa16U
 xauTeMtgcQTinQdyRIDyB1+M54uIq8lejHt/nuUVqmDHCowU8KoTMBleqPZnGetBf43r
 G/qzCl0rvP38yQSfIytdrDHhHJT8rXZ1Hbfh9//5Ruwue3ZEdPXxFIeWC0+z3oWaLjT/
 cxFaRzWwK5J6cUuy4i3lqxvXh2VrdQEXwsorMI7Zb0ngsusA+qJqSEoCF1IzD964I3I8
 NY0A==
X-Gm-Message-State: AOJu0YwNMWdzBMmAbGTlE+dzbM5zf7iVilz5JHop/bjkmsxdAr/SltXj
 q92vLCwq+Pt56I/c6nx+vq32a2s8zBQIHUalj9EAT0kkQZUOzDjDaQgxE7zDX8t6aS5UEl/eFyy
 d2ECNv9Uv02snTosg7jyz62+yQNUY8/cIAHq2ZjK1EX2uoJAfozbpaPBJVZ76z2fiUJzKFx1H4X
 VaEHJ2LvdXFQ3/2u4c4Qt5NsptGMwk6U2dPLMVxSc=
X-Gm-Gg: ASbGncuzIKVD1yR/Uc2vTuAgU1ZaY3Ibr52v3hmLRS7AsOT37BcLuhNa49pB/HEK3Gf
 EsjyWV1nnDaNKk1cDh/QBD4eXdW3IoHvLdbQcraG4uPZsBT8qLVnqJvpIYTgAtjcOtTSF0xhnjS
 +mwiWYa2XDES2V0EGrpDuR3t72X6SAZB9U0uL+GoQkgvfL7TUkPCvEbeJVq9Kj4UWZz5fhca5K3
 S8K1ssEXGVTReEUL/C2c4nomQDmkHo6rSXUj3/19iyXpxbKQtnQ6NOH+kTKLVuczZlkjPllEVCG
 n7Ip4w==
X-Received: by 2002:a05:6000:156b:b0:388:c61d:43e4 with SMTP id
 ffacd0b85a97d-38c520a32d7mr1492788f8f.45.1738139837220; 
 Wed, 29 Jan 2025 00:37:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJ2JBVwDeE5q+t4+y/fdB5TiihcdAFlZk8IBbk2dI09eqwmGHptgSAX2WpRv7w7LvjbQLJzg==
X-Received: by 2002:a05:6000:156b:b0:388:c61d:43e4 with SMTP id
 ffacd0b85a97d-38c520a32d7mr1492744f8f.45.1738139836452; 
 Wed, 29 Jan 2025 00:37:16 -0800 (PST)
Received: from [192.168.10.3] ([151.62.97.55])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc11adbsm14845235e9.8.2025.01.29.00.37.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2025 00:37:15 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	qemu-rust@nongnu.org
Subject: [PATCH] rust: add docs
Date: Wed, 29 Jan 2025 09:37:15 +0100
Message-ID: <20250129083715.1321520-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 URIBL_SBL_A=0.1 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/index-process.rst |   1 +
 docs/devel/rust.rst          | 423 +++++++++++++++++++++++++++++++++++
 2 files changed, 424 insertions(+)
 create mode 100644 docs/devel/rust.rst

diff --git a/docs/devel/index-process.rst b/docs/devel/index-process.rst
index 362f97ee300..cb7c6640fd2 100644
--- a/docs/devel/index-process.rst
+++ b/docs/devel/index-process.rst
@@ -17,3 +17,4 @@ Notes about how to interact with the community and how and where to submit patch
    stable-process
    submitting-a-pull-request
    secure-coding-practices
+   rust
diff --git a/docs/devel/rust.rst b/docs/devel/rust.rst
new file mode 100644
index 00000000000..2fc4e94fb6d
--- /dev/null
+++ b/docs/devel/rust.rst
@@ -0,0 +1,423 @@
+.. |msrv| replace:: 1.63.0
+
+Rust in QEMU
+============
+
+Rust in QEMU is a project to enable using the Rust programming language
+to add new functionality to QEMU.
+
+Right now, the focus is on making it possible to write devices that inherit
+from ``SysBusDevice`` in `*safe*`__ Rust.  Later, it may become possible
+to write other kinds of devices (e.g. PCI devices that can do DMA),
+complete boards, or backends (e.g. block device formats).
+
+__ https://doc.rust-lang.org/nomicon/meet-safe-and-unsafe.html
+
+Building the Rust in QEMU code
+------------------------------
+
+The Rust in QEMU code is included in the emulators via Meson.  Meson
+invokes rustc directly, building static libraries that are then linked
+together with the C code.  This is completely automatic when you run
+``make`` or ``ninja``.
+
+However, QEMU's build system also tries to be easy to use for people who
+are accustomed to the more "normal" Cargo-based development workflow.
+In particular:
+
+* the set of warnings and lints that are used to build QEMU always
+  comes from the ``rust/Cargo.toml`` workspace file
+
+* it is also possible to use ``cargo`` for common Rust-specific coding
+  tasks, in particular to invoke ``clippy``, ``rustfmt`` and ``rustdoc``.
+
+To this end, QEMU includes a ``build.rs`` build script that picks up
+generated sources from QEMU's build directory and puts it in Cargo's
+output directory (typically ``rust/target/``).  A vanilla invocation
+of Cargo will complain that it cannot find the generated sources,
+which can be fixed in different ways:
+
+* by using special shorthand targets in the QEMU build directory::
+
+    make clippy
+    make rustfmt
+    make rustdoc
+
+* by invoking ``cargo`` through the Meson `development environment`__
+  feature::
+
+    pyvenv/bin/meson devenv -w ../rust cargo clippy --tests
+    pyvenv/bin/meson devenv -w ../rust cargo fmt
+
+  If you are going to use ``cargo`` repeatedly, ``pyvenv/bin/meson devenv``
+  will enter a shell where commands like ``cargo clippy`` just work.
+
+__ https://mesonbuild.com/Commands.html#devenv
+
+* by pointing the ``MESON_BUILD_ROOT`` to the top of your QEMU build
+  tree.  This third method is useful if you are using ``rust-analyzer``;
+  you can set the environment variable through the
+  ``rust-analyzer.cargo.extraEnv`` setting.
+
+As shown above, you can use the ``--tests`` option as usual to operate on test
+code.  Note however that you cannot *build* or run tests via ``cargo``, because
+they need support C code from QEMU that Cargo does not know about.  Tests can
+be run via ``meson test`` or ``make``::
+
+   make check-rust
+
+Building Rust code with ``--enable-modules`` is not supported yet.
+
+Supported tools
+'''''''''''''''
+
+QEMU supports rustc version 1.63.0 and newer.  Notably, the following features
+are missing:
+
+* ``core::ffi`` (1.64.0).  Use ``std::os::raw`` and ``std::ffi`` instead.
+
+* ``cast_mut()``/``cast_const()`` (1.65.0).  Use ``as`` instead.
+
+* "let ... else" (1.65.0).  Use ``if let`` instead.  This is currently patched
+  in QEMU's vendored copy of the bilge and ``pinned_init`` crates.
+
+* Generic Associated Types (1.65.0)
+
+* ``CStr::from_bytes_with_nul()`` as a ``const`` function (1.72.0).
+
+* "Return position ``impl Trait`` in Traits" (1.75.0, can be useful with
+  the pinned-init create).
+
+* MaybeUninit::zeroed() as a ``const`` function (1.75.0).  QEMU uses a
+  ``Zeroable`` trait, and you can implement it to provide by hand a
+  ``Zeroable::ZERO`` associated constant.
+
+* ``c"" literals`` (stable in 1.77.0).  QEMU provides a ``c_str!()`` macro
+  to define ``CStr`` constants easily
+
+* ``offset_of!`` (stable in 1.77.0).  QEMU uses ``offset_of!()`` heavily; it
+  provides a replacement in the ``qemu_api`` crate, but it does not support
+  lifetime parameters and therefore `&'a Something` fields in the struct
+  may have to be replaced by `NonNull<Something>`.  *Nested* ``offset_of!``
+  was only stabilized in Rust 1.82.0, but it is not used.
+
+* inline const expression (stable in 1.79.0), currently worked around with
+  associated constants in the ``FnCall`` trait.
+
+* associated constants have to be explicitly marked ``'static`` (`changed in
+  1.81.0`__)
+
+* ``&raw`` (stable in 1.82.0).  Use ``addr_of!`` and ``addr_of_mut!`` instead,
+  though hopefully the need for raw pointers will go down over time.
+
+* ``new_uninit`` (stable in 1.82.0).  This is used internally by the ``pinned_init``
+  crate, and patched in QEMU's vendored copy of the crate.
+
+* referencing statics in constants (stable in 1.83.0).  For now use a const
+  function; this is an important limitation for QEMU's migration stream
+  architecture (VMState).  Right now, VMState lacks type safety because
+  it is hard to place the ``VMStateField`` definitions in traits.
+
+* associated const equality would be nice to have for some users of
+  ``callbacks::FnCall``, but is still experimental.  ``ASSERT_IS_SOME``
+  replaces it.
+
+__ https://github.com/rust-lang/rust/pull/125258
+
+It is expected that QEMU will advance its minimum supported version of
+rustc to 1.77.0 as soon; as of January 2025, blockers for that right now
+are Debian bookworm and 32-bit MIPS processors.  This unfortunately
+means that references to statics in constants will remain an issue.
+
+QEMU also supports version 0.60.x of bindgen, which is missing option
+``--generate-cstr``.  This option requires version 0.66.x and will
+be adopted as soon as supporting these older versions is not necessary
+anymore.
+
+Writing Rust code in QEMU
+-------------------------
+
+Right now QEMU includes three crates:
+
+* ``qemu_api`` for bindings to C code and useful functionality
+
+* ``qemu_api_macros`` defines several procedural macros that are useful when
+  writing C code
+
+* ``pl011`` (under ``rust/hw/char/pl011``) is the sample device that is being
+  used to further develop ``qemu_api`` and ``qemu_api_macros``.  It is a functional
+  replacement for the ``hw/char/pl011.c`` file.
+
+This section explains how to work with them.
+
+Status
+''''''
+
+Modules of ``qemu_api`` can be defined as:
+
+- *complete*: ready for use in new devices; if applicable, the API supports the
+  full functionality available in C
+
+- *stable*: ready for production use, the API is safe and should not undergo
+  major changes
+
+- *proof of concept*: the API is subject to change but allows working with safe
+  Rust
+
+- *initial*: the API is in its initial stages; it requires large amount of
+  unsafe code; it might have soundness or type-safety issues
+
+The status of the modules are
+
+================ ======================
+module           status
+================ ======================
+``assertions``   stable
+``bitops``       complete
+``callbacks``    complete
+``cell``         stable
+``c_str``        complete
+``irq``          complete
+``module``       complete
+``offset_of``    stable
+``qdev``         stable
+``qom``          stable
+``sysbus``       stable
+``vmstate``      proof of concept
+``zeroable``     stable
+================ ======================
+
+Common pitfalls
+'''''''''''''''
+
+Rust has very strict rules with respect to how you get an exclusive (``&mut``)
+reference; failure to respect those rules is a source of undefined behavior.
+In particular, even if a value is loaded from a raw mutable pointer (``*mut``),
+it *cannot* be casted to ``&mut`` unless the value was stored to the ``*mut``
+from a mutable reference.  Furthermore, it is undefined behavior if any
+shared reference was created between the store to the ``*mut`` and the load::
+
+    let mut p: u32 = 42;
+    let p_mut = &mut p;                              // 1
+    let p_raw = p_mut as *mut u32;                   // 2
+
+    // p_raw keeps the mutable reference "alive"
+
+    let p_shared = &p;                               // 3
+    println!("access from &u32: {}", *p_shared);
+
+    // Bring back the mutable reference, its lifetime overlaps
+    // with that of a shared reference.
+    let p_mut = unsafe { &mut *p_raw };              // 4
+    println!("access from &mut 32: {}", *p_mut);
+
+    println!("access from &u32: {}", *p_shared);     // 5
+
+These rules can be tested with `MIRI`__, for example.
+
+__ https://github.com/rust-lang/miri
+
+Almost all Rust code in QEMU will involve QOM objects, and pointers to these
+objects are *shared*, for example because they are part of the QOM composition
+tree.  This creates exactly the above scenario:
+
+1. a QOM object is created
+
+2. a ``*mut`` is created, for example as the opaque value for a ``MemoryRegion``
+
+3. the QOM object is placed in the composition tree
+
+4. a memory access dereferences the opaque value to a ``&mut``
+
+5. but the shared reference is still present in the composition tree
+
+Because of this, QOM objects should almost always use ``&self`` instead
+of ``&mut self``; access to internal fields must use *interior mutability*
+to go from a shared reference to a ``&mut``.
+
+Whenever C code provides you with an opaque ``void *``, avoid converting it
+to a Rust mutable reference, and use a shared reference instead.  Rust code
+will then have to use QEMU's ``BqlRefCell`` and ``BqlCell`` type, which
+enforce that locking rules for the "Big QEMU Lock" are respected.  These cell
+types are also known to the ``vmstate`` crate, which is able to "look inside"
+them when building an in-memory representation of a ``struct``s layout.
+Note that the same is not true of a ``RefCell`` or ``Mutex``.
+
+In the future, similar cell types might also be provided for ``AioContext``-based
+locking as well.
+
+Writing bindings to C code
+''''''''''''''''''''''''''
+
+Here are some things to keep in mind when working on the ``qemu_api`` crate.
+
+**Look at existing code**
+  Very often, similar idioms in C code correspond to similar tricks in
+  Rust bindings.  If the C code uses ``offsetof``, look at qdev properties
+  or ``vmstate``.  If the C code has a complex const struct, look at
+  ``MemoryRegion``.  Reuse existing patterns for handling lifetimes;
+  for example use ``&T`` for QOM objects that do not need a reference
+  count (including those that can be embedded in other objects) and
+  ``Owned<T>`` for those that need it.
+
+**Use the type system**
+  Bindings often will need access information that is specific to a type
+  (either a builtin one or a user-defined one) in order to pass it to C
+  functions.  Put them in a trait and access it through generic parameters.
+  The ``vmstate`` module has examples of how to retrieve type information
+  for the fields of a Rust ``struct``.
+
+**Prefer unsafe traits to unsafe functions**
+  Unsafe traits are much easier to prove correct than unsafe functions.
+  They are an excellent place to store metadata that can later be accessed
+  by generic functions.  C code usually places metadata in global variables;
+  in Rust, they can be stored in traits and then turned into ``static``
+  variables.  Often, unsafe traits can be generated by procedural macros.
+
+**Document limitations due to old Rust versions**
+  If you need to settle for an inferior solution because of the currently
+  supported set of Rust versions, document it in the source and in this
+  file.  This ensures that it can be fixed when the minimum supported
+  version is bumped.
+
+**Keep locking in mind**.
+  When marking a type ``Sync``, be careful of whether it needs the big
+  QEMU lock.  Use ``BqlCell`` and ``BqlRefCell`` for interior data,
+  or assert ``bql_locked()``.
+
+**Don't be afraid of complexity, but document and isolate it**
+  It's okay to be tricky; device code is written more often than bindings
+  code and it's important that it is idiomatic.  However, you should strive
+  to isolate any tricks in a place (for example a ``struct``, a trait
+  or a macro) where it can be documented and tested.  If needed, include
+  toy versions of the code in the documentation.
+
+Writing procedural macros
+'''''''''''''''''''''''''
+
+By conventions, procedural macros are split in two functions, one
+returning ``Result<proc_macro2::TokenStream, MacroError>` with the body of
+the procedural macro, and the second returning ``proc_macro::TokenStream``
+which is the actual procedural macro.  The former's name is the same as
+the latter with the ``_or_error`` suffix.  The code for the latter is more
+or less fixed; it follows the following template, which is fixed apart
+from the type after ``as`` in the invocation of ``parse_macro_input!``::
+
+    #[proc_macro_derive(Object)]
+    pub fn derive_object(input: TokenStream) -> TokenStream {
+        let input = parse_macro_input!(input as DeriveInput);
+        let expanded = derive_object_or_error(input).unwrap_or_else(Into::into);
+
+        TokenStream::from(expanded)
+    }
+
+The ``qemu_api_macros`` crate has utility functions to examine a
+``DeriveInput`` and perform common checks (e.g. looking for a struct
+with named fields).  These functions return ``Result<..., MacroError>``
+and can be used easily in the procedural macro function::
+
+    fn derive_object_or_error(input: DeriveInput) ->
+        Result<proc_macro2::TokenStream, MacroError>
+    {
+        is_c_repr(&input, "#[derive(Object)]")?;
+
+        let name = &input.ident;
+        let parent = &get_fields(&input, "#[derive(Object)]")?[0].ident;
+        ...
+    }
+
+Use procedural macros with care.  They are mostly useful for two purposes:
+
+* Performing consistency checks; for example ``#[derive(Object)]`` checks
+  that the structure has ``#[repr[C])`` and that the type of the first field
+  is consistent with the ``ObjectType`` declaration.
+
+* Extracting information from Rust source code into traits, typically based
+  on types and attributes.  For example, ``#[derive(TryInto)]`` builds an
+  implementation of ``TryFrom``, and it uses the ``#[repr(...)]`` attribute
+  as the ``TryFrom`` source and error types.
+
+Procedural macros can be hard to debug and test; if the code generation
+exceeds a few lines of code, it may be worthwhile to delegate work to
+"regular" declarative (``macro_rules!``) macros and write unit tests for
+those instead.
+
+
+Coding style
+''''''''''''
+
+Code should pass clippy and be formatted with rustfmt.
+
+Right now, only the nightly version of ``rustfmt`` is supported.  This
+might change in the future.  While CI checks for correct formatting via
+``cargo fmt --check``, maintainers can fix this for you when applying patches.
+
+It is expected that ``qemu_api`` provides full ``rustdoc`` documentation for
+bindings that are in their final shape or close.
+
+Adding dependencies
+-------------------
+
+Generally, the set of dependent crates is kept small.  Think twice before
+adding a new external crate, especially if it comes with a large set of
+dependencies itself.  Sometimes QEMU only needs a small subset of the
+functionality; see for example QEMU's ``assertions`` or ``c_str`` modules.
+
+On top of this recommendation, adding external crates to QEMU is a
+slightly complicated process, mostly due to the need to teach Meson how
+to build them.  While Meson has initial support for parsing ``Cargo.lock``
+files, it is still highly experimental and is therefore not used.
+
+First of all, the crate must be added to the relevant ``Cargo.toml`` files.
+External crates must be added as subprojects for Meson to learn how to
+build them, as well as to the relevant ``Cargo.toml`` files.  Because the
+``rust/`` directory forms a Cargo `workspace`__, there is a single
+``rust/Cargo.lock`` file for the whole build.
+
+__ https://doc.rust-lang.org/cargo/reference/workspaces.html#virtual-workspace
+
+Choose a version of the crate that works with QEMU's minimum supported
+Rust version (|msrv|).
+
+Second, a new ``wrap`` file must be added to teach Meson how to download the
+crate.  The wrap file must be named ``NAME-SEMVER-rs.wrap``, where ``NAME``
+is the name of the crate and ``SEMVER`` is the version up to and including the
+first non-zero number.  For example, a crate with version ``0.2.3`` will use
+``0.2`` for its ``SEMVER``, while a crate with version ``1.0.84`` will use ``1``.
+
+Third, the Meson rules to build the crate must be added at
+``subprojects/NAME-SEMVER-rs/meson.build``.  Generally this includes:
+
+* ``subproject`` and ``dependency`` lines for all dependent crates
+
+* a ``static_library`` or ``rust.proc_macro`` line to perform the actual build
+
+* ``declare_dependency`` and a ``meson.override_dependency`` lines to expose
+  the result to QEMU and to other subprojects
+
+Remember to add ``native: true`` to ``dependency``, ``static_library`` and
+``meson.override_dependency`` for dependencies of procedural macros.
+If a crate is needed in both procedural macros and QEMU binaries, everything
+apart from ``subproject`` must be duplicated to build both native and
+non-native versions of the crate.
+
+It's important to specify the right compiler options.  These include:
+
+* the language edition (which can be found in the ``Cargo.toml`` file)
+
+* the ``--cfg`` (which have to be "reverse engineered" from the ``build.rs``
+  file of the crate).
+
+* usually, a ``--cap-lints allow`` argument to hide warnings from rustc
+  or clippy.
+
+After every change to the ``meson.build`` file you have to update the patched
+version with ``meson subprojects update --reset ``NAME-SEMVER-rs``.  This might
+be automated in the future.
+
+Also, after every change to the ``meson.build`` file it is strongly suggested to
+do a dummy change to the ``.wrap`` file (for example adding a comment like
+``# version 2``), which will help Meson notice that the subproject is out of date.
+
+As a last step, add the new subproject to ``scripts/archive-source.sh``,
+``scripts/make-release`` and ``subprojects/.gitignore``.
-- 
2.48.1


